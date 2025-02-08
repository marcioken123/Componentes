// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctDialects.pas' rev: 31.00 (Windows)

#ifndef LmdsctdialectsHPP
#define LmdsctdialectsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Win.Registry.hpp>
#include <Vcl.Dialogs.hpp>
#include <ToolsAPI.hpp>
#include <LMDSctImporterParser.hpp>
#include <LMDSctImporterFileUtils.hpp>
#include <LMDSctImporterUnitDoc.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctdialects
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDIDEDialectException;
class DELPHICLASS TLMDIDEDialectProvider;
class DELPHICLASS TLMDIDEDialect;
class DELPHICLASS TLMDIDEDialect6;
class DELPHICLASS TLMDIDEDialect7;
class DELPHICLASS TLMDIDEDialect9;
class DELPHICLASS TLMDIDEDialect10;
class DELPHICLASS TLMDIDEDialect11;
class DELPHICLASS TLMDIDEDialect12;
class DELPHICLASS TLMDIDEDialect14;
class DELPHICLASS TLMDIDEDialect15;
class DELPHICLASS TLMDIDEDialect16;
class DELPHICLASS TLMDIDEDialect17;
class DELPHICLASS TLMDIDEDialect18;
class DELPHICLASS TLMDIDEDialect19;
class DELPHICLASS TLMDIDEDialect20;
class DELPHICLASS TLMDIDEDialect21;
class DELPHICLASS TLMDIDEDialect22;
class DELPHICLASS TLMDIDEDialect23;
class DELPHICLASS TLMDIDEDialect24;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDIDEDialectException : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDIDEDialectException(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDIDEDialectException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDIDEDialectException(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDIDEDialectException(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDIDEDialectException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDIDEDialectException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDIDEDialectException(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDIDEDialectException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDIDEDialectException(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDIDEDialectException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDIDEDialectException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDIDEDialectException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDIDEDialectException(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialectProvider : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	__classmethod void __fastcall CreateDialect(/* out */ TLMDIDEDialect* &AResult);
	
public:
	__classmethod TLMDIDEDialect* __fastcall GetDialect();
public:
	/* TObject.Create */ inline __fastcall TLMDIDEDialectProvider(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDIDEDialectProvider(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect : public Lmdsctimporterunitdoc::ILMDUnitDocEnvironment
{
	typedef Lmdsctimporterunitdoc::ILMDUnitDocEnvironment inherited;
	
private:
	System::UnicodeString __fastcall GetIDEOptionValue(const System::UnicodeString AOptName);
	bool __fastcall TryGetIDEConfigKey(bool AIsLocMachine, const System::UnicodeString ASubkey, const System::UnicodeString AValName, /* out */ System::UnicodeString &AResult);
	System::UnicodeString __fastcall GetIDEConfigKey(bool AIsLocMachine, const System::UnicodeString ASubkey, const System::UnicodeString AValName);
	System::UnicodeString __fastcall ExpandIDEMacro(const System::UnicodeString APath);
	void __fastcall AddPathList(const System::UnicodeString APathList, System::Classes::TStrings* AResult);
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void) = 0 ;
	
public:
	__fastcall TLMDIDEDialect(void);
	__fastcall virtual ~TLMDIDEDialect(void);
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult);
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect6 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect6(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect6(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect7 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect7(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect7(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect9 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect9(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect9(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect10 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect10(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect10(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect11 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect11(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect11(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect12 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect12(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect12(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect14 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect14(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect14(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect15 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect15(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect15(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect16 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect16(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect16(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect17 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect17(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect17(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect18 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect18(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect18(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect19 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect19(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect19(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect20 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect20(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect20(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect21 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect21(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect21(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect22 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect22(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect22(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect23 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect23(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect23(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIDEDialect24 : public TLMDIDEDialect
{
	typedef TLMDIDEDialect inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetIDEMacro(void);
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser);
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult);
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void);
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult);
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
public:
	/* TLMDIDEDialect.Create */ inline __fastcall TLMDIDEDialect24(void) : TLMDIDEDialect() { }
	/* TLMDIDEDialect.Destroy */ inline __fastcall virtual ~TLMDIDEDialect24(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsctdialects */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTDIALECTS)
using namespace Lmdsctdialects;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctdialectsHPP
