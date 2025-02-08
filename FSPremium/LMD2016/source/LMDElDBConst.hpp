// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDElDBConst.pas' rev: 31.00 (Windows)

#ifndef LmdeldbconstHPP
#define LmdeldbconstHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdeldbconst
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EOnUndefinedGridColumnsDataSet;
class DELPHICLASS ENoValidDataSetName;
class DELPHICLASS EIncorrectFieldName;
class DELPHICLASS EIncorrectColumnIndex;
class DELPHICLASS EErrorInPattern;
class DELPHICLASS EOnGoToBookmark;
class DELPHICLASS EOnMoveError;
class DELPHICLASS EOnErrorInRelation;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElUpdateStylesType : unsigned char { stPattern, stFontAndStyles, stHint, stCheckBox, stImages, stCaption, stShowCaption };

typedef System::UnicodeString TElTableName;

#pragma pack(push,4)
class PASCALIMPLEMENTATION EOnUndefinedGridColumnsDataSet : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EOnUndefinedGridColumnsDataSet(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EOnUndefinedGridColumnsDataSet(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EOnUndefinedGridColumnsDataSet(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EOnUndefinedGridColumnsDataSet(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EOnUndefinedGridColumnsDataSet(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EOnUndefinedGridColumnsDataSet(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EOnUndefinedGridColumnsDataSet(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EOnUndefinedGridColumnsDataSet(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EOnUndefinedGridColumnsDataSet(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EOnUndefinedGridColumnsDataSet(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EOnUndefinedGridColumnsDataSet(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EOnUndefinedGridColumnsDataSet(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EOnUndefinedGridColumnsDataSet(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ENoValidDataSetName : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ENoValidDataSetName(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ENoValidDataSetName(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ENoValidDataSetName(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ENoValidDataSetName(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ENoValidDataSetName(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ENoValidDataSetName(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ENoValidDataSetName(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ENoValidDataSetName(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ENoValidDataSetName(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ENoValidDataSetName(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ENoValidDataSetName(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ENoValidDataSetName(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ENoValidDataSetName(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION EIncorrectFieldName : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EIncorrectFieldName(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EIncorrectFieldName(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EIncorrectFieldName(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EIncorrectFieldName(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EIncorrectFieldName(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EIncorrectFieldName(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EIncorrectFieldName(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EIncorrectFieldName(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EIncorrectFieldName(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EIncorrectFieldName(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EIncorrectFieldName(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EIncorrectFieldName(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EIncorrectFieldName(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION EIncorrectColumnIndex : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EIncorrectColumnIndex(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EIncorrectColumnIndex(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EIncorrectColumnIndex(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EIncorrectColumnIndex(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EIncorrectColumnIndex(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EIncorrectColumnIndex(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EIncorrectColumnIndex(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EIncorrectColumnIndex(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EIncorrectColumnIndex(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EIncorrectColumnIndex(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EIncorrectColumnIndex(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EIncorrectColumnIndex(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EIncorrectColumnIndex(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION EErrorInPattern : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EErrorInPattern(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EErrorInPattern(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EErrorInPattern(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EErrorInPattern(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EErrorInPattern(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EErrorInPattern(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EErrorInPattern(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EErrorInPattern(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EErrorInPattern(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EErrorInPattern(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EErrorInPattern(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EErrorInPattern(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EErrorInPattern(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION EOnGoToBookmark : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EOnGoToBookmark(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EOnGoToBookmark(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EOnGoToBookmark(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EOnGoToBookmark(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EOnGoToBookmark(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EOnGoToBookmark(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EOnGoToBookmark(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EOnGoToBookmark(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EOnGoToBookmark(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EOnGoToBookmark(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EOnGoToBookmark(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EOnGoToBookmark(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EOnGoToBookmark(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION EOnMoveError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EOnMoveError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EOnMoveError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EOnMoveError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EOnMoveError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EOnMoveError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EOnMoveError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EOnMoveError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EOnMoveError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EOnMoveError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EOnMoveError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EOnMoveError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EOnMoveError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EOnMoveError(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION EOnErrorInRelation : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EOnErrorInRelation(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EOnErrorInRelation(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EOnErrorInRelation(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EOnErrorInRelation(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EOnErrorInRelation(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EOnErrorInRelation(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EOnErrorInRelation(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EOnErrorInRelation(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EOnErrorInRelation(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EOnErrorInRelation(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EOnErrorInRelation(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EOnErrorInRelation(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EOnErrorInRelation(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TElDBUnicodeMode : unsigned char { umFieldType, umForceUTF8, umForceUnicode };

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::ResourceString _SErrorInMTree;
#define Lmdeldbconst_SErrorInMTree System::LoadResourceString(&Lmdeldbconst::_SErrorInMTree)
extern DELPHI_PACKAGE System::ResourceString _SDeleteFromDenyDataSet;
#define Lmdeldbconst_SDeleteFromDenyDataSet System::LoadResourceString(&Lmdeldbconst::_SDeleteFromDenyDataSet)
extern DELPHI_PACKAGE System::ResourceString _SMasterDetailIncompatible;
#define Lmdeldbconst_SMasterDetailIncompatible System::LoadResourceString(&Lmdeldbconst::_SMasterDetailIncompatible)
extern DELPHI_PACKAGE System::ResourceString _SOnErrorInRelation;
#define Lmdeldbconst_SOnErrorInRelation System::LoadResourceString(&Lmdeldbconst::_SOnErrorInRelation)
extern DELPHI_PACKAGE System::ResourceString _SNoSetInstall;
#define Lmdeldbconst_SNoSetInstall System::LoadResourceString(&Lmdeldbconst::_SNoSetInstall)
extern DELPHI_PACKAGE System::ResourceString _SNoDSetInstall;
#define Lmdeldbconst_SNoDSetInstall System::LoadResourceString(&Lmdeldbconst::_SNoDSetInstall)
extern DELPHI_PACKAGE System::ResourceString _SOnMoveError;
#define Lmdeldbconst_SOnMoveError System::LoadResourceString(&Lmdeldbconst::_SOnMoveError)
extern DELPHI_PACKAGE System::ResourceString _SOnGoToBookmark;
#define Lmdeldbconst_SOnGoToBookmark System::LoadResourceString(&Lmdeldbconst::_SOnGoToBookmark)
extern DELPHI_PACKAGE System::ResourceString _SErrorInPattern;
#define Lmdeldbconst_SErrorInPattern System::LoadResourceString(&Lmdeldbconst::_SErrorInPattern)
extern DELPHI_PACKAGE System::ResourceString _SErrorPrebuildLevel;
#define Lmdeldbconst_SErrorPrebuildLevel System::LoadResourceString(&Lmdeldbconst::_SErrorPrebuildLevel)
extern DELPHI_PACKAGE System::ResourceString _SNoColumnSetAssigned;
#define Lmdeldbconst_SNoColumnSetAssigned System::LoadResourceString(&Lmdeldbconst::_SNoColumnSetAssigned)
extern DELPHI_PACKAGE System::ResourceString _SNoValidDataSetName;
#define Lmdeldbconst_SNoValidDataSetName System::LoadResourceString(&Lmdeldbconst::_SNoValidDataSetName)
extern DELPHI_PACKAGE System::ResourceString _SIncorrectColumnIndex;
#define Lmdeldbconst_SIncorrectColumnIndex System::LoadResourceString(&Lmdeldbconst::_SIncorrectColumnIndex)
extern DELPHI_PACKAGE System::ResourceString _SIncorrectFieldName;
#define Lmdeldbconst_SIncorrectFieldName System::LoadResourceString(&Lmdeldbconst::_SIncorrectFieldName)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrFirst;
#define Lmdeldbconst_SLMDNbrFirst System::LoadResourceString(&Lmdeldbconst::_SLMDNbrFirst)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrPrior;
#define Lmdeldbconst_SLMDNbrPrior System::LoadResourceString(&Lmdeldbconst::_SLMDNbrPrior)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrNext;
#define Lmdeldbconst_SLMDNbrNext System::LoadResourceString(&Lmdeldbconst::_SLMDNbrNext)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrLast;
#define Lmdeldbconst_SLMDNbrLast System::LoadResourceString(&Lmdeldbconst::_SLMDNbrLast)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrInsert;
#define Lmdeldbconst_SLMDNbrInsert System::LoadResourceString(&Lmdeldbconst::_SLMDNbrInsert)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrDelete;
#define Lmdeldbconst_SLMDNbrDelete System::LoadResourceString(&Lmdeldbconst::_SLMDNbrDelete)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrEdit;
#define Lmdeldbconst_SLMDNbrEdit System::LoadResourceString(&Lmdeldbconst::_SLMDNbrEdit)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrPost;
#define Lmdeldbconst_SLMDNbrPost System::LoadResourceString(&Lmdeldbconst::_SLMDNbrPost)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrCancel;
#define Lmdeldbconst_SLMDNbrCancel System::LoadResourceString(&Lmdeldbconst::_SLMDNbrCancel)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrRefresh;
#define Lmdeldbconst_SLMDNbrRefresh System::LoadResourceString(&Lmdeldbconst::_SLMDNbrRefresh)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrSearch;
#define Lmdeldbconst_SLMDNbrSearch System::LoadResourceString(&Lmdeldbconst::_SLMDNbrSearch)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrSetFilter;
#define Lmdeldbconst_SLMDNbrSetFilter System::LoadResourceString(&Lmdeldbconst::_SLMDNbrSetFilter)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrRemoveFilter;
#define Lmdeldbconst_SLMDNbrRemoveFilter System::LoadResourceString(&Lmdeldbconst::_SLMDNbrRemoveFilter)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrClear;
#define Lmdeldbconst_SLMDNbrClear System::LoadResourceString(&Lmdeldbconst::_SLMDNbrClear)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrOpen;
#define Lmdeldbconst_SLMDNbrOpen System::LoadResourceString(&Lmdeldbconst::_SLMDNbrOpen)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrClose;
#define Lmdeldbconst_SLMDNbrClose System::LoadResourceString(&Lmdeldbconst::_SLMDNbrClose)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrFindFirst;
#define Lmdeldbconst_SLMDNbrFindFirst System::LoadResourceString(&Lmdeldbconst::_SLMDNbrFindFirst)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrFindPrior;
#define Lmdeldbconst_SLMDNbrFindPrior System::LoadResourceString(&Lmdeldbconst::_SLMDNbrFindPrior)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrFindNext;
#define Lmdeldbconst_SLMDNbrFindNext System::LoadResourceString(&Lmdeldbconst::_SLMDNbrFindNext)
extern DELPHI_PACKAGE System::ResourceString _SLMDNbrFindLast;
#define Lmdeldbconst_SLMDNbrFindLast System::LoadResourceString(&Lmdeldbconst::_SLMDNbrFindLast)
extern DELPHI_PACKAGE System::ResourceString _SLMDTnbrFirstRoot;
#define Lmdeldbconst_SLMDTnbrFirstRoot System::LoadResourceString(&Lmdeldbconst::_SLMDTnbrFirstRoot)
extern DELPHI_PACKAGE System::ResourceString _SLMDTnbrFirst;
#define Lmdeldbconst_SLMDTnbrFirst System::LoadResourceString(&Lmdeldbconst::_SLMDTnbrFirst)
extern DELPHI_PACKAGE System::ResourceString _SLMDTnbrPrior;
#define Lmdeldbconst_SLMDTnbrPrior System::LoadResourceString(&Lmdeldbconst::_SLMDTnbrPrior)
extern DELPHI_PACKAGE System::ResourceString _SLMDTnbrNext;
#define Lmdeldbconst_SLMDTnbrNext System::LoadResourceString(&Lmdeldbconst::_SLMDTnbrNext)
extern DELPHI_PACKAGE System::ResourceString _SLMDTnbrLast;
#define Lmdeldbconst_SLMDTnbrLast System::LoadResourceString(&Lmdeldbconst::_SLMDTnbrLast)
extern DELPHI_PACKAGE System::ResourceString _SLMDTnbrLastRoot;
#define Lmdeldbconst_SLMDTnbrLastRoot System::LoadResourceString(&Lmdeldbconst::_SLMDTnbrLastRoot)
extern DELPHI_PACKAGE System::ResourceString _SLMDTnbrInsert;
#define Lmdeldbconst_SLMDTnbrInsert System::LoadResourceString(&Lmdeldbconst::_SLMDTnbrInsert)
extern DELPHI_PACKAGE System::ResourceString _SLMDTnbrInsertSubItem;
#define Lmdeldbconst_SLMDTnbrInsertSubItem System::LoadResourceString(&Lmdeldbconst::_SLMDTnbrInsertSubItem)
extern DELPHI_PACKAGE System::ResourceString _SLMDTnbrDelete;
#define Lmdeldbconst_SLMDTnbrDelete System::LoadResourceString(&Lmdeldbconst::_SLMDTnbrDelete)
extern DELPHI_PACKAGE System::ResourceString _SLMDTnbrEdit;
#define Lmdeldbconst_SLMDTnbrEdit System::LoadResourceString(&Lmdeldbconst::_SLMDTnbrEdit)
extern DELPHI_PACKAGE System::ResourceString _SLMDTnbrRefresh;
#define Lmdeldbconst_SLMDTnbrRefresh System::LoadResourceString(&Lmdeldbconst::_SLMDTnbrRefresh)
}	/* namespace Lmdeldbconst */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDELDBCONST)
using namespace Lmdeldbconst;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdeldbconstHPP
