// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSearchFileGrep.pas' rev: 31.00 (Windows)

#ifndef LmdsearchfilegrepHPP
#define LmdsearchfilegrepHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <LMDSearchBase.hpp>
#include <LMDRefineUnit.hpp>
#include <LMDDateTime.hpp>
#include <LMDThreads.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsearchfilegrep
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSSearchThread;
struct TLMDSPFileRecord;
class DELPHICLASS TLMDSearchFileGrep;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSSearchThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	TLMDSearchFileGrep* FOwner;
	System::UnicodeString FToBeAdded;
	void __fastcall StartGrep(void);
	
protected:
	void __fastcall SAddF(void);
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TLMDSSearchThread(TLMDSearchFileGrep* aOwner, bool CreateSuspended);
	__fastcall virtual ~TLMDSSearchThread(void);
	void __fastcall SyncAddFound(const System::UnicodeString s);
};


enum DECLSPEC_DENUM TLMDSPFileAttribute : unsigned char { fmReadOnly, fmArchive, fmAnyfile, fmSystem, fmHidden };

typedef System::Set<TLMDSPFileAttribute, TLMDSPFileAttribute::fmReadOnly, TLMDSPFileAttribute::fmHidden> TLMDSPFileAttributes;

enum DECLSPEC_DENUM TLMDSPResult : unsigned char { srsDir, srsFilename, srsAttr, srsSize, srsCreateDate, srsLastAccessDate, srsLastModifiedDate };

typedef System::Set<TLMDSPResult, TLMDSPResult::srsDir, TLMDSPResult::srsLastModifiedDate> TLMDSPResults;

enum DECLSPEC_DENUM TLMDSPCheckDate : unsigned char { scdCreateAfter, scdCreateBefore, scdAccessedAfter, scdAccessedBefore, scdModifiedAfter, scdModifiedBefore };

typedef System::Set<TLMDSPCheckDate, TLMDSPCheckDate::scdCreateAfter, TLMDSPCheckDate::scdModifiedBefore> TLMDSPCheckDates;

typedef TLMDSPFileRecord *PLMDSPFileRecord;

struct DECLSPEC_DRECORD TLMDSPFileRecord
{
public:
	System::UnicodeString Directory;
	System::UnicodeString FileName;
	TLMDSPFileAttributes Attributes;
	System::UnicodeString AttributeString;
	__int64 FileSize;
	System::TDateTime CreateDate;
	System::TDateTime LastAccess;
	System::TDateTime LastModified;
};


typedef void __fastcall (__closure *TLMDSPOnFileChangeEvent)(System::TObject* Sender, System::UnicodeString filename);

typedef void __fastcall (__closure *TLMDSPOnFoundEvent)(System::TObject* Sender, PLMDSPFileRecord filedata);

class PASCALIMPLEMENTATION TLMDSearchFileGrep : public Lmdsearchbase::TLMDSearchBaseDlgComponent
{
	typedef Lmdsearchbase::TLMDSearchBaseDlgComponent inherited;
	
private:
	System::UnicodeString FFileMasks;
	System::UnicodeString FDirs;
	__int64 FSizeMin;
	__int64 FSizeMax;
	TLMDSPFileAttributes FAttr;
	Lmddatetime::TLMDDateTime* FCreatedMin;
	Lmddatetime::TLMDDateTime* FCreatedMax;
	Lmddatetime::TLMDDateTime* FAccessedMin;
	Lmddatetime::TLMDDateTime* FAccessedMax;
	Lmddatetime::TLMDDateTime* FModifiedMin;
	Lmddatetime::TLMDDateTime* FModifiedMax;
	System::Classes::TStrings* FFound;
	bool FCreateFoundList;
	bool FCancelling;
	bool FRecurseSubDirs;
	bool FThreaded;
	System::Classes::TThreadPriority FThreadPriority;
	System::Classes::TNotifyEvent FOnEnd;
	System::Classes::TNotifyEvent FOnCancel;
	System::Classes::TNotifyEvent FOnFinished;
	TLMDSPOnFoundEvent FOnFound;
	TLMDSPResults FReturnVals;
	TLMDSPCheckDates FLookFor;
	TLMDSSearchThread* FSrchThread;
	TLMDSPOnFileChangeEvent FOnDirChanged;
	TLMDSPOnFileChangeEvent FOnFileChanged;
	TLMDSPOnFileChangeEvent FOnErrorOpenFile;
	Lmdrefineunit::TLMDRefine* FRefine;
	Lmdthreads::TLMDMutex* FPauseMutex;
	System::Classes::TNotifyEvent FOnTemplateInvalid;
	bool FTemplateValid;
	bool FPaused;
	void __fastcall SetDateTime(int index, Lmddatetime::TLMDDateTime* aValue);
	void __fastcall SetThreadPriority(System::Classes::TThreadPriority aValue);
	void __fastcall SetPaused(const bool Value);
	
protected:
	virtual void __fastcall SetTemplate(const Lmdsearchbase::TLMDSearchTemplate Value);
	virtual Lmdsearchbase::TLMDSearchTemplate __fastcall GetTemplate(void);
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	System::TDateTime __fastcall GetCheckDate(TLMDSPCheckDate Index);
	System::Word __fastcall getAttr(void);
	void __fastcall GrepFiles(const System::UnicodeString StartDir, const System::UnicodeString FileMasks, bool RecurseSubDir, __int64 MinSize, __int64 MaxSize, System::TDateTime MinCreateDate, System::TDateTime MaxCreateDate, System::TDateTime MinLastAccessDate, System::TDateTime MaxLastAccessDate, System::TDateTime MinLastWriteDate, System::TDateTime MaxLastWriteDate, System::Word Attr, Lmdrefineunit::TLMDRefine* Refine, Lmdsearchbase::TLMDSearchOptions* ContentSearchOptions, System::UnicodeString content, TLMDSPOnFileChangeEvent OnError = 0x0);
	
public:
	__fastcall virtual TLMDSearchFileGrep(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDSearchFileGrep(void);
	void __fastcall Execute(void);
	void __fastcall Cancel(void);
	bool __fastcall ShowBuilderDialog(Vcl::Forms::TCustomForm* AOwner = (Vcl::Forms::TCustomForm*)(0x0), int X = 0xffffffff, int Y = 0xffffffff);
	__property System::Classes::TStrings* FileNames = {read=FFound};
	__property bool TemplateValid = {read=FTemplateValid, nodefault};
	__property bool Paused = {read=FPaused, write=SetPaused, nodefault};
	
__published:
	__property About = {default=0};
	__property bool InternalFoundList = {read=FCreateFoundList, write=FCreateFoundList, default=1};
	__property TLMDSPResults ResultValues = {read=FReturnVals, write=FReturnVals, default=3};
	__property Lmddatetime::TLMDDateTime* AccessedAfter = {read=FAccessedMin, write=SetDateTime, index=2};
	__property Lmddatetime::TLMDDateTime* AccessedBefore = {read=FAccessedMax, write=SetDateTime, index=3};
	__property TLMDSPFileAttributes Attributes = {read=FAttr, write=FAttr, default=4};
	__property TLMDSPCheckDates CheckDates = {read=FLookFor, write=FLookFor, default=0};
	__property Lmddatetime::TLMDDateTime* CreatedAfter = {read=FCreatedMin, write=SetDateTime, index=0};
	__property Lmddatetime::TLMDDateTime* CreatedBefore = {read=FCreatedMax, write=SetDateTime, index=1};
	__property System::UnicodeString Dirs = {read=FDirs, write=FDirs};
	__property System::UnicodeString FileMasks = {read=FFileMasks, write=FFileMasks};
	__property __int64 MinSize = {read=FSizeMin, write=FSizeMin, default=0};
	__property __int64 MaxSize = {read=FSizeMax, write=FSizeMax, default=0};
	__property Lmddatetime::TLMDDateTime* ModifiedAfter = {read=FModifiedMin, write=SetDateTime, index=4};
	__property Lmddatetime::TLMDDateTime* ModifiedBefore = {read=FModifiedMax, write=SetDateTime, index=5};
	__property bool ThreadedSearch = {read=FThreaded, write=FThreaded, default=1};
	__property System::Classes::TThreadPriority ThreadPriority = {read=FThreadPriority, write=SetThreadPriority, default=3};
	__property bool RecurseSubDirs = {read=FRecurseSubDirs, write=FRecurseSubDirs, default=1};
	__property System::Classes::TNotifyEvent OnTemplateInvalid = {read=FOnTemplateInvalid, write=FOnTemplateInvalid};
	__property System::Classes::TNotifyEvent OnFinished = {read=FOnFinished, write=FOnFinished};
	__property System::Classes::TNotifyEvent OnCancel = {read=FOnCancel, write=FOnCancel};
	__property TLMDSPOnFoundEvent OnFound = {read=FOnFound, write=FOnFound};
	__property TLMDSPOnFileChangeEvent OnDirChange = {read=FOnDirChanged, write=FOnDirChanged};
	__property System::Classes::TNotifyEvent OnEnd = {read=FOnEnd, write=FOnEnd};
	__property TLMDSPOnFileChangeEvent OnFileChange = {read=FOnFileChanged, write=FOnFileChanged};
	__property TLMDSPOnFileChangeEvent OnErrorOpenFile = {read=FOnErrorOpenFile, write=FOnErrorOpenFile};
	__property SearchOptions;
	__property SearchString = {default=0};
	__property DlgBuilderOptions = {default=339};
	__property OnDlgHelpClick;
	__property OnDlgCustomize;
};


//-- var, const, procedure ---------------------------------------------------
static const System::WideChar FileMaskDelimiter = (System::WideChar)(0x3b);
}	/* namespace Lmdsearchfilegrep */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSEARCHFILEGREP)
using namespace Lmdsearchfilegrep;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsearchfilegrepHPP
