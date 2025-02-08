// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCabSupport.pas' rev: 31.00 (Windows)

#ifndef LmdcabsupportHPP
#define LmdcabsupportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Forms.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>
#include <LMDProcs.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcabsupport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDCabError;
struct TLMDFDICabinetInfo;
class DELPHICLASS TLMDCabinetItem;
class DELPHICLASS TLMDCabinetItems;
class DELPHICLASS TLMDCustomCabComponent;
class DELPHICLASS TLMDCabCompress;
class DELPHICLASS TLMDCabDeCompress;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDCabError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDCabError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDCabError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDCabError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDCabError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDCabError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDCabError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDCabError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDCabError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDCabError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDCabError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDCabError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDCabError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDCabError(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDFDIError : unsigned char { FDINone, FDICabinetNotFound, FDINotACabinet, FDIUnknownCABVersion, FDICorruptCAB, FDIAllocFail, FDIBadCompressType, FDIMDIFail, FDITargetFile, FDIReserveMismatch, FDIWrongCabinet, FDIUserAbort };

enum DECLSPEC_DENUM TLMDFCIError : unsigned char { FCINone, FCIOpenSrc, FCIReadSrc, FCIAllocFail, FCITempFile, FCIBadCompressType, FCICabFile, FCIUserAbort, FCIMCIMail };

struct DECLSPEC_DRECORD TLMDFDICabinetInfo
{
public:
	int cbCabinet;
	System::Word cFolders;
	System::Word cFiles;
	System::Word setID;
	System::Word iCabinet;
	int fReserve;
	int hasprev;
	int hasnext;
};


class PASCALIMPLEMENTATION TLMDCabinetItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::TDateTime FDate;
	System::AnsiString FFileName;
	__int64 FSize;
	bool FSelected;
	System::AnsiString FDestPath;
	System::AnsiString __fastcall GetShortFileName(void);
	
public:
	__fastcall virtual TLMDCabinetItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDCabinetItem(void);
	__property __int64 FileSize = {read=FSize, write=FSize};
	__property System::TDateTime FileDate = {read=FDate, write=FDate};
	__property bool Selected = {read=FSelected, write=FSelected, nodefault};
	__property System::AnsiString FileName = {read=FFileName, write=FFileName};
	__property System::AnsiString ShortFileName = {read=GetShortFileName};
	__property System::AnsiString DestinationPath = {read=FDestPath, write=FDestPath};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCabinetItems : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TLMDCabinetItem* operator[](int index) { return this->Items[index]; }
	
private:
	TLMDCabinetItem* FSelected;
	HIDESBASE TLMDCabinetItem* __fastcall GetItem(int index);
	int __fastcall GetSelCount(void);
	
public:
	__fastcall TLMDCabinetItems(TLMDCustomCabComponent* Owner);
	__fastcall virtual ~TLMDCabinetItems(void);
	HIDESBASE TLMDCabinetItem* __fastcall Add(void);
	__property TLMDCabinetItem* Selected = {read=FSelected, write=FSelected};
	__property int SelCount = {read=GetSelCount, nodefault};
	__property TLMDCabinetItem* Items[int index] = {read=GetItem/*, default*/};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDCabProgessEvent)(System::TObject* Sender, const System::AnsiString FileName, int FileIndex, __int64 CurrentFileSize, __int64 CurrentCabSize);

typedef void __fastcall (__closure *TLMDCabErrorEvent)(System::TObject* Sender, System::Word ErrorCode);

class PASCALIMPLEMENTATION TLMDCustomCabComponent : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
public:
	TLMDCabinetItem* operator[](int Index) { return this->Item[Index]; }
	
private:
	TLMDCabinetItems* FItems;
	System::Byte FInternal;
	System::Word FLastError;
	int FCurrent;
	__int64 FSourceSize;
	bool FRaiseExceptions;
	TLMDCabProgessEvent FOnProgress;
	System::Classes::TNotifyEvent FOnStart;
	System::Classes::TNotifyEvent FOnFinish;
	TLMDCabErrorEvent FOnError;
	int __fastcall GetFileCount(void);
	TLMDCabinetItem* __fastcall GetItem(int Index);
	TLMDCabinetItem* __fastcall GetItemByName(const System::AnsiString Index);
	
protected:
	System::Sysutils::TFileName FFileName;
	virtual __int64 __fastcall GetTotalFileSize(void) = 0 ;
	void __fastcall DoHandleError(System::Word ErrorCode);
	
public:
	__fastcall virtual TLMDCustomCabComponent(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomCabComponent(void);
	void __fastcall Reset(void);
	__property TLMDCabinetItems* Items = {read=FItems};
	__property TLMDCabinetItem* Item[int Index] = {read=GetItem/*, default*/};
	__property TLMDCabinetItem* ItemByName[const System::AnsiString Index] = {read=GetItemByName};
	__property int FileCount = {read=GetFileCount, nodefault};
	__property System::Word LastError = {read=FLastError, nodefault};
	__property __int64 OriginalFileSize = {read=GetTotalFileSize};
	__property __int64 SourceFileSize = {read=FSourceSize};
	
__published:
	__property About = {default=0};
	__property bool RaiseExceptions = {read=FRaiseExceptions, write=FRaiseExceptions, default=0};
	__property TLMDCabErrorEvent OnError = {read=FOnError, write=FOnError};
	__property System::Classes::TNotifyEvent OnFinish = {read=FOnFinish, write=FOnFinish};
	__property System::Classes::TNotifyEvent OnStart = {read=FOnStart, write=FOnStart};
	__property TLMDCabProgessEvent OnProgress = {read=FOnProgress, write=FOnProgress};
};


enum DECLSPEC_DENUM TLMDCabCompressionType : unsigned char { cctNone, cctMSZIP, cctLZX };

enum DECLSPEC_DENUM TLMDCabLZXLevel : unsigned char { cllLowest, cllLower, cllLow, cllMedium, cllHigh, cllHigher, cllHighest };

class PASCALIMPLEMENTATION TLMDCabCompress : public TLMDCustomCabComponent
{
	typedef TLMDCustomCabComponent inherited;
	
private:
	System::Sysutils::TFileName FFileName;
	TLMDCabCompressionType FCompressionType;
	TLMDCabLZXLevel FCompressionLevel;
	__int64 FCompressedSize;
	System::Word __fastcall GetCompType(void);
	
protected:
	int __fastcall DoProgress(unsigned typeStatus, unsigned cb1, unsigned cb2);
	virtual __int64 __fastcall GetTotalFileSize(void);
	
public:
	__fastcall virtual TLMDCabCompress(System::Classes::TComponent* AOwner);
	void __fastcall AddFolder(const System::AnsiString SourcePath)/* overload */;
	void __fastcall AddFolder(const System::AnsiString SourcePath, const System::AnsiString DestPath)/* overload */;
	void __fastcall AddFolder(const System::AnsiString SourcePath, const System::AnsiString DestPath, bool RecurseDirs)/* overload */;
	void __fastcall AddFile(const System::AnsiString SourceName, const System::AnsiString DestPath = System::AnsiString());
	bool __fastcall Compress(void);
	__property __int64 CompressedFileSize = {read=FCompressedSize};
	
__published:
	__property TLMDCabCompressionType CompressionType = {read=FCompressionType, write=FCompressionType, default=1};
	__property TLMDCabLZXLevel CompressionLZXLevel = {read=FCompressionLevel, write=FCompressionLevel, default=6};
	__property System::Sysutils::TFileName FileName = {read=FFileName, write=FFileName};
public:
	/* TLMDCustomCabComponent.Destroy */ inline __fastcall virtual ~TLMDCabCompress(void) { }
	
};


enum DECLSPEC_DENUM TLMDCabDeCompressOption : unsigned char { dcoForceDirectories, dcoOverwriteFiles };

typedef System::Set<TLMDCabDeCompressOption, TLMDCabDeCompressOption::dcoForceDirectories, TLMDCabDeCompressOption::dcoOverwriteFiles> TLMDCabDeCompressOptions;

typedef void __fastcall (__closure *TLMDCabItemRequestEvent)(System::TObject* Sender, const System::AnsiString ItemName, bool &Cancel);

class PASCALIMPLEMENTATION TLMDCabDeCompress : public TLMDCustomCabComponent
{
	typedef TLMDCustomCabComponent inherited;
	
private:
	System::AnsiString FDestination;
	int FExtractFileCount;
	TLMDCabDeCompressOptions FOptions;
	__int64 FCurrentDeCompressed;
	TLMDCabItemRequestEvent FOnFolderRequired;
	TLMDCabItemRequestEvent FOnFileExists;
	void __fastcall SetFileName(const System::Sysutils::TFileName Value);
	int __fastcall GetSelCount(void);
	bool __fastcall GetSelected(int index);
	void __fastcall SetSelected(int index, const bool Value);
	
protected:
	virtual bool __fastcall DoDeCompress(System::Byte op = (System::Byte)(0x0));
	virtual __int64 __fastcall GetTotalFileSize(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDCabDeCompress(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCabDeCompress(void);
	void __fastcall Refresh(void);
	bool __fastcall Extract(int index)/* overload */;
	bool __fastcall Extract(const System::Sysutils::TFileName Value)/* overload */;
	bool __fastcall Extract(TLMDCabinetItem* item)/* overload */;
	bool __fastcall Extract(bool Selected = false)/* overload */;
	bool __fastcall IsCabFile(const System::Sysutils::TFileName Value);
	bool __fastcall IsMultiPart(const System::Sysutils::TFileName Value);
	int __fastcall FileCountFromFile(const System::Sysutils::TFileName Value);
	void __fastcall GetFileList(System::Classes::TStrings* aList);
	void __fastcall SelectAll(bool doSelect = true);
	__property bool Selected[int index] = {read=GetSelected, write=SetSelected};
	__property int SelCount = {read=GetSelCount, nodefault};
	__property int ExtractFileCount = {read=FExtractFileCount, nodefault};
	
__published:
	__property System::Sysutils::TFileName FileName = {read=FFileName, write=SetFileName};
	__property System::AnsiString DestinationPath = {read=FDestination, write=FDestination};
	__property TLMDCabDeCompressOptions Options = {read=FOptions, write=FOptions, default=3};
	__property TLMDCabItemRequestEvent OnFileExists = {read=FOnFileExists, write=FOnFileExists};
	__property TLMDCabItemRequestEvent OnFolderRequired = {read=FOnFolderRequired, write=FOnFolderRequired};
};


//-- var, const, procedure ---------------------------------------------------
#define defCabOptions (System::Set<TLMDCabDeCompressOption, TLMDCabDeCompressOption::dcoForceDirectories, TLMDCabDeCompressOption::dcoOverwriteFiles>() << TLMDCabDeCompressOption::dcoForceDirectories << TLMDCabDeCompressOption::dcoOverwriteFiles )
extern DELPHI_PACKAGE bool __fastcall LMDCABIsValidFile(const System::AnsiString FileName)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDCABIsValidFile(const System::AnsiString FileName, TLMDFDICabinetInfo &info)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDCABIsMultiPart(const System::AnsiString FileName);
extern DELPHI_PACKAGE int __fastcall LMDCABGetFileCount(const System::AnsiString FileName);
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDCabFCIErrorToString(System::Word ErrorCode);
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDCabFDIErrorToString(System::Word ErrorCode);
extern DELPHI_PACKAGE bool __fastcall LMDCabCompressFile(const System::AnsiString CABFileName, const System::AnsiString SourceFileName, TLMDCabCompressionType compType = (TLMDCabCompressionType)(0x1));
extern DELPHI_PACKAGE bool __fastcall LMDCabCompressFolder(const System::AnsiString CABFileName, const System::AnsiString FolderName, bool subDirs = true, TLMDCabCompressionType compType = (TLMDCabCompressionType)(0x1));
extern DELPHI_PACKAGE bool __fastcall LMDCabGetFileList(const System::AnsiString CABFileName, System::Classes::TStrings* filelist);
extern DELPHI_PACKAGE bool __fastcall LMDCABExtractFile(const System::AnsiString CABFileName, const System::AnsiString DestPath, const System::AnsiString SourceFileName);
extern DELPHI_PACKAGE bool __fastcall LMDCABExtractAll(const System::AnsiString CABFileName, const System::AnsiString DestPath);
}	/* namespace Lmdcabsupport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCABSUPPORT)
using namespace Lmdcabsupport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcabsupportHPP
