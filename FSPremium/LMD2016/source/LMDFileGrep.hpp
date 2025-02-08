// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFileGrep.pas' rev: 31.00 (Windows)

#ifndef LmdfilegrepHPP
#define LmdfilegrepHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDShBase.hpp>
#include <LMDDateTime.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfilegrep
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSearchThread;
class DELPHICLASS TLMDFileGrep;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDFoundEvent)(System::TObject* Sender, System::UnicodeString found);

typedef void __fastcall (__closure *TLMDFileChangeEvent)(System::TObject* Sender, System::UnicodeString name);

class PASCALIMPLEMENTATION TLMDSearchThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	TLMDFileGrep* FOwner;
	System::UnicodeString FToBeAdded;
	void __fastcall StartGrep(void);
	
protected:
	void __fastcall SAddF(void);
	
public:
	virtual void __fastcall Execute(void);
	__fastcall TLMDSearchThread(TLMDFileGrep* aOwner, bool CreateSuspended);
	__fastcall virtual ~TLMDSearchThread(void);
	void __fastcall SyncAddFound(System::UnicodeString s);
};


enum DECLSPEC_DENUM TLMDFileGrepAttribute : unsigned char { fmReadOnly, fmArchive, fmAnyfile, fmSystem, fmHidden };

typedef System::Set<TLMDFileGrepAttribute, TLMDFileGrepAttribute::fmReadOnly, TLMDFileGrepAttribute::fmHidden> TLMDFileGrepAttributes;

enum DECLSPEC_DENUM TLMDReturnValue : unsigned char { rvDir, rvFilename, rvAttr, rvSize, rvCreateDate, rvLastAccessDate, rvLastModifiedDate };

typedef System::Set<TLMDReturnValue, TLMDReturnValue::rvDir, TLMDReturnValue::rvLastModifiedDate> TLMDReturnValues;

enum DECLSPEC_DENUM TLMDLookFor : unsigned char { lfCreateAfter, lfCreateBefore, lfAccessedAfter, lfAccessedBefore, lfModifiedAfter, lfModifiedBefore };

typedef System::Set<TLMDLookFor, TLMDLookFor::lfCreateAfter, TLMDLookFor::lfModifiedBefore> TLMDLookFors;

class PASCALIMPLEMENTATION TLMDFileGrep : public Lmdshbase::TLMDShellComponent
{
	typedef Lmdshbase::TLMDShellComponent inherited;
	
private:
	System::UnicodeString FFileMasks;
	System::UnicodeString FDirs;
	System::UnicodeString FContent;
	__int64 FSizeMin;
	__int64 FSizeMax;
	TLMDFileGrepAttributes FAttr;
	Lmddatetime::TLMDDateTime* FCreatedMin;
	Lmddatetime::TLMDDateTime* FCreatedMax;
	Lmddatetime::TLMDDateTime* FAccessedMin;
	Lmddatetime::TLMDDateTime* FAccessedMax;
	Lmddatetime::TLMDDateTime* FModifiedMin;
	Lmddatetime::TLMDDateTime* FModifiedMax;
	System::Classes::TStrings* FFound;
	bool FCreateFoundList;
	bool FCaseSensitiveContent;
	bool FCancelling;
	bool FRecurseSubDirs;
	bool FThreaded;
	System::Classes::TThreadPriority FThreadPriority;
	System::Classes::TNotifyEvent FOnEnd;
	System::Classes::TNotifyEvent FOnCancel;
	System::Classes::TNotifyEvent FOnFinished;
	TLMDFoundEvent FOnFound;
	TLMDReturnValues FReturnVals;
	TLMDLookFors FLookFor;
	System::WideChar FReturnDelimiter;
	TLMDSearchThread* FSrchThread;
	TLMDFileChangeEvent FOnDirChanged;
	TLMDFileChangeEvent FOnFileChanged;
	TLMDFileChangeEvent FOnErrorOpenFile;
	void __fastcall SetDateTime(int index, Lmddatetime::TLMDDateTime* aValue);
	void __fastcall SetThreadPriority(System::Classes::TThreadPriority aValue);
	void __fastcall ReadString(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	System::TDateTime __fastcall lfDate(TLMDLookFor val);
	System::Word __fastcall getAttr(void);
	void __fastcall GrepFiles(const System::UnicodeString StartDir, const System::UnicodeString FileMasks, bool RecurseSubDir, __int64 MinSize, __int64 MaxSize, System::TDateTime MinCreateDate, System::TDateTime MaxCreateDate, System::TDateTime MinLastAccessDate, System::TDateTime MaxLastAccessDate, System::TDateTime MinLastWriteDate, System::TDateTime MaxLastWriteDate, System::Word Attr, bool CaseSensitiveContent, System::UnicodeString Content, TLMDFileChangeEvent OnError = 0x0);
	
public:
	__fastcall virtual TLMDFileGrep(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDFileGrep(void);
	void __fastcall Grep(void);
	void __fastcall Cancel(void);
	__property System::Classes::TStrings* Found = {read=FFound};
	__property System::Classes::TStrings* Files = {read=FFound};
	
__published:
	__property About = {default=0};
	__property System::UnicodeString FileMasks = {read=FFileMasks, write=FFileMasks};
	__property System::UnicodeString Dirs = {read=FDirs, write=FDirs};
	__property TLMDFileGrepAttributes Attributes = {read=FAttr, write=FAttr, default=4};
	__property Lmddatetime::TLMDDateTime* CreatedAfter = {read=FCreatedMin, write=SetDateTime, index=0};
	__property Lmddatetime::TLMDDateTime* CreatedBefore = {read=FCreatedMax, write=SetDateTime, index=1};
	__property Lmddatetime::TLMDDateTime* AccessedAfter = {read=FAccessedMin, write=SetDateTime, index=2};
	__property Lmddatetime::TLMDDateTime* AccessedBefore = {read=FAccessedMax, write=SetDateTime, index=3};
	__property Lmddatetime::TLMDDateTime* ModifiedAfter = {read=FModifiedMin, write=SetDateTime, index=4};
	__property Lmddatetime::TLMDDateTime* ModifiedBefore = {read=FModifiedMax, write=SetDateTime, index=5};
	__property __int64 MinSize = {read=FSizeMin, write=FSizeMin, default=0};
	__property __int64 MaxSize = {read=FSizeMax, write=FSizeMax, default=0};
	__property System::UnicodeString Content = {read=FContent, write=FContent};
	__property bool CaseSensitiveContent = {read=FCaseSensitiveContent, write=FCaseSensitiveContent, default=1};
	__property bool ThreadedSearch = {read=FThreaded, write=FThreaded, default=1};
	__property System::Classes::TThreadPriority ThreadPriority = {read=FThreadPriority, write=SetThreadPriority, default=3};
	__property bool RecurseSubDirs = {read=FRecurseSubDirs, write=FRecurseSubDirs, default=1};
	__property TLMDReturnValues ReturnValues = {read=FReturnVals, write=FReturnVals, default=3};
	__property System::WideChar ReturnDelimiter = {read=FReturnDelimiter, write=FReturnDelimiter, default=59};
	__property TLMDLookFors LookForDates = {read=FLookFor, write=FLookFor, default=0};
	__property bool InternalFoundList = {read=FCreateFoundList, write=FCreateFoundList, default=1};
	__property System::Classes::TNotifyEvent OnFinished = {read=FOnFinished, write=FOnFinished};
	__property System::Classes::TNotifyEvent OnCancel = {read=FOnCancel, write=FOnCancel};
	__property TLMDFoundEvent OnFound = {read=FOnFound, write=FOnFound};
	__property TLMDFileChangeEvent OnDirChange = {read=FOnDirChanged, write=FOnDirChanged};
	__property System::Classes::TNotifyEvent OnEnd = {read=FOnEnd, write=FOnEnd};
	__property TLMDFileChangeEvent OnFileChange = {read=FOnFileChanged, write=FOnFileChanged};
	__property TLMDFileChangeEvent OnErrorOpenFile = {read=FOnErrorOpenFile, write=FOnErrorOpenFile};
};


//-- var, const, procedure ---------------------------------------------------
static const System::WideChar FileMaskDelimiter = (System::WideChar)(0x3b);
}	/* namespace Lmdfilegrep */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFILEGREP)
using namespace Lmdfilegrep;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfilegrepHPP
