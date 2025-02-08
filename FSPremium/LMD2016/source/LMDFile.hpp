// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFile.pas' rev: 31.00 (Windows)

#ifndef LmdfileHPP
#define LmdfileHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.FileCtrl.hpp>
#include <Winapi.ShellAPI.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDClass.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfile
{
//-- forward type declarations -----------------------------------------------
struct TActualData;
class DELPHICLASS TLMDFile;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDFileOption : unsigned char { foVerifyAction, foNewFileAsActual, foCopiedFileAsActual, foCopyTimeStamp };

typedef System::Set<TLMDFileOption, TLMDFileOption::foVerifyAction, TLMDFileOption::foCopyTimeStamp> TLMDFileOptions;

enum DECLSPEC_DENUM TLMDFileAction : unsigned char { fcNone, fcChange, fcCreate, fcCopy, fcMove, fcDelete, fcRename, fcExecute };

enum DECLSPEC_DENUM TLMDFilePosAction : unsigned char { fpStart, fpProgress, fpEnd };

enum DECLSPEC_DENUM TFileErrorcode : unsigned char { feNone, feErrorCreateFile, feErrorExecuteFile, feErrorOpenSrc, feErrorOpenDest, feFileAlreadyExist, feFileReadOnly, feFileNotExist, feFileDestSrcSame, feMoveSrcNotKilled, feDelFileNotKilled, feDateTimeConvErr, feDateTimeWriteErr, feSetAttrFailed, feRenameFailed, feChangeExtFailed, feParameterNull };

struct DECLSPEC_DRECORD TActualData
{
public:
	TLMDFileAction Action;
	System::UnicodeString Source;
	System::UnicodeString Destination;
};


typedef void __fastcall (__closure *TLMDErrorEvent)(System::TObject* Sender, TFileErrorcode Errorcode, const TActualData &ActData);

typedef void __fastcall (__closure *TLMDActionEvent)(System::TObject* Sender, const TActualData &ActData);

class PASCALIMPLEMENTATION TLMDFile : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	int FBufferSize;
	TActualData FActualData;
	Vcl::Filectrl::TFileType FFileAttributes;
	System::UnicodeString FFileAttrShort;
	bool FFileexists;
	System::UnicodeString FFileExt;
	System::UnicodeString FFilePath;
	System::UnicodeString FFileName;
	System::UnicodeString FFileNameExt;
	System::UnicodeString FFileNameAlone;
	System::TDateTime FFileDateTime;
	System::UnicodeString FFileDate;
	System::UnicodeString FFileTime;
	int FFileSize;
	System::Byte FProcessed;
	TLMDErrorEvent FOnError;
	TLMDActionEvent FOnStart;
	TLMDActionEvent FOnEnd;
	TLMDActionEvent FOnProgress;
	TLMDFileOptions FOptions;
	void __fastcall SetActualData(TLMDFileAction Act, const System::UnicodeString cw1, const System::UnicodeString cw2);
	void __fastcall SetBufferSize(int aValue);
	void __fastcall SetFileAttributes(Vcl::Filectrl::TFileType aValue);
	void __fastcall SetFileAttrShort(System::UnicodeString aValue);
	void __fastcall SetFileName(System::UnicodeString aValue);
	void __fastcall SetFileNameAlone(System::UnicodeString aValue);
	void __fastcall SetFileNameExt(System::UnicodeString aValue);
	void __fastcall SetOptions(TLMDFileOptions aValue);
	void __fastcall SetFileExists(bool aValue);
	void __fastcall SetFileExt(System::UnicodeString aValue);
	void __fastcall SetFilePath(System::UnicodeString aValue);
	void __fastcall SetFileDateTime(System::UnicodeString aValue, bool mode);
	void __fastcall SetFileDate(System::UnicodeString aValue);
	void __fastcall SetFileTime(System::UnicodeString aValue);
	void __fastcall SetFileSize(int aValue);
	void __fastcall SetCreateFile(System::Sysutils::TFileName aValue);
	void __fastcall SetCopyFile(System::Sysutils::TFileName aValue);
	void __fastcall SetMoveFile(System::Sysutils::TFileName aValue);
	void __fastcall SetDeleteFile(System::Sysutils::TFileName aValue);
	void __fastcall SetRenameFile(System::Sysutils::TFileName aValue);
	void __fastcall SetExecuteFile(System::Sysutils::TFileName aValue);
	Vcl::Filectrl::TFileType __fastcall GetFileAttributes(void);
	int __fastcall GetFileSize(const System::Sysutils::TFileName filename);
	void __fastcall CopyMoveFile(System::Sysutils::TFileName aValue, bool mode);
	void __fastcall PrepareOnEvent(TLMDFilePosAction mode, TFileErrorcode error);
	bool __fastcall checkifExist(const System::Sysutils::TFileName aValue);
	bool __fastcall checkifEmpty(const System::Sysutils::TFileName aValue);
	void __fastcall RefreshState(void);
	
public:
	__fastcall virtual TLMDFile(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFile(void);
	__property System::Sysutils::TFileName aCreateFile = {write=SetCreateFile, stored=false};
	__property System::Sysutils::TFileName aCopyFile = {write=SetCopyFile, stored=false};
	__property System::Sysutils::TFileName aMoveFile = {write=SetMoveFile, stored=false};
	__property System::Sysutils::TFileName aDeleteFile = {write=SetDeleteFile, stored=false};
	__property System::Sysutils::TFileName aRenameFile = {write=SetRenameFile, stored=false};
	__property System::Sysutils::TFileName aExecuteFile = {write=SetExecuteFile, stored=false};
	NativeUInt __fastcall ExecuteFile(const System::UnicodeString FileName, int ShowCmd);
	System::Sysutils::TFileName __fastcall GetFileExecutable(void);
	__property System::Byte Processed = {read=FProcessed, stored=false, nodefault};
	bool __fastcall TestAttr(const System::Sysutils::TFileName aValue, System::Word Attr);
	
__published:
	__property About = {default=0};
	__property int BufferSize = {read=FBufferSize, write=SetBufferSize, default=8192};
	__property TLMDErrorEvent OnError = {read=FOnError, write=FOnError};
	__property TLMDActionEvent OnStart = {read=FOnStart, write=FOnStart};
	__property TLMDActionEvent OnEnd = {read=FOnEnd, write=FOnEnd};
	__property TLMDActionEvent OnProgress = {read=FOnProgress, write=FOnProgress};
	__property TLMDFileOptions Options = {read=FOptions, write=SetOptions, default=11};
	__property System::UnicodeString FileDate = {read=FFileDate, write=SetFileDate, stored=false};
	__property System::UnicodeString FileTime = {read=FFileTime, write=SetFileTime, stored=false};
	__property System::UnicodeString FileExt = {read=FFileExt, write=SetFileExt, stored=false};
	__property System::UnicodeString FilePath = {read=FFilePath, write=SetFilePath, stored=false};
	__property System::UnicodeString FileNameExt = {read=FFileNameExt, write=SetFileNameExt, stored=false};
	__property System::UnicodeString FileNameAlone = {read=FFileNameAlone, write=SetFileNameAlone, stored=false};
	__property System::UnicodeString FileName = {read=FFileName, write=SetFileName, stored=false};
	__property Vcl::Filectrl::TFileType FileAttributes = {read=FFileAttributes, write=SetFileAttributes, stored=false, nodefault};
	__property System::UnicodeString FileAttrShort = {read=FFileAttrShort, write=SetFileAttrShort, stored=false};
	__property bool FileExist = {read=FFileexists, write=SetFileExists, stored=false, nodefault};
	__property int FileSize = {read=FFileSize, write=SetFileSize, stored=false, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfile */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFILE)
using namespace Lmdfile;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfileHPP
