// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShFolder.pas' rev: 31.00 (Windows)

#ifndef LmdshfolderHPP
#define LmdshfolderHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.ShlObj.hpp>
#include <LMDShBase.hpp>
#include <LMDShItem.hpp>
#include <LMDShController.hpp>
#include <LMDShMisc.hpp>
#include <LMDShUtils.hpp>
#include <LMDCustomComponent.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshfolder
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellFolder;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDShellSortType : unsigned char { stNone, stName, stTypeName, stSize, stAttributes, stCreateDate, stCreateTime, stCreateDateTime, stAccessDate, stAccessTime, stAccessDateTime, stWriteDate, stWriteTime, stWriteDateTime };

enum DECLSPEC_DENUM TLMDShellSortOrder : unsigned char { soAsc, soDesc };

typedef void __fastcall (__closure *TLMDShellFilterEvent)(System::TObject* Sender, Lmdshitem::TLMDShellItem* Item, bool &Accept);

typedef void __fastcall (__closure *TLMDShellDriveInfoEvent)(System::TObject* Sender, System::UnicodeString Drive, __int64 TotalSpace, __int64 FreeSpace);

typedef void __fastcall (__closure *TLMDShellInfoEvent)(System::TObject* Sender, int Count, __int64 Size);

class PASCALIMPLEMENTATION TLMDShellFolder : public Lmdshcontroller::TLMDShellController
{
	typedef Lmdshcontroller::TLMDShellController inherited;
	
private:
	Lmdshutils::TLMDRoot FRootFolder;
	System::Uitypes::TColor FCompressedColor;
	Lmdshitem::TLMDShellFolderOptions FOptions;
	System::UnicodeString FFilter;
	bool FFiltered;
	TLMDShellSortType FSortType;
	TLMDShellSortOrder FSortOrder;
	System::Classes::TNotifyEvent FOnChange;
	TLMDShellFilterEvent FOnFilter;
	TLMDShellInfoEvent FOnFolderInfoEvent;
	TLMDShellDriveInfoEvent FOnDriveInfoEvent;
	void __fastcall SetRootFolder(const Lmdshutils::TLMDRoot aValue);
	void __fastcall LoadCustomFolder(System::Classes::TReader* Reader);
	void __fastcall LoadSystemFolder(System::Classes::TReader* Reader);
	bool __fastcall isNoDefault(void);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall TriggerActiveFolderChanged(void);
	
public:
	__fastcall virtual TLMDShellFolder(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDShellFolder(void);
	void __fastcall RefreshControls(void);
	HIDESBASE void __fastcall ChDir(Lmdshutils::TLMDSystemFolder aRootFolder)/* overload */;
	
__published:
	__property About = {default=0};
	__property Lmdshutils::TLMDRoot RootFolder = {read=FRootFolder, write=SetRootFolder, stored=isNoDefault};
	__property Lmdshitem::TLMDShellFolderOptions Options = {read=FOptions, write=FOptions, default=0};
	__property System::Uitypes::TColor CompressedColor = {read=FCompressedColor, write=FCompressedColor, default=0};
	__property System::UnicodeString Filter = {read=FFilter, write=FFilter};
	__property bool Filtered = {read=FFiltered, write=FFiltered, default=0};
	__property TLMDShellSortType SortType = {read=FSortType, write=FSortType, default=0};
	__property TLMDShellSortOrder SortOrder = {read=FSortOrder, write=FSortOrder, default=0};
	__property ObserveChanges = {default=1};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TLMDShellFilterEvent OnFilter = {read=FOnFilter, write=FOnFilter};
	__property TLMDShellInfoEvent OnFolderInfoEvent = {read=FOnFolderInfoEvent, write=FOnFolderInfoEvent};
	__property TLMDShellDriveInfoEvent OnDriveInfoEvent = {read=FOnDriveInfoEvent, write=FOnDriveInfoEvent};
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  ChDir(Winapi::Shlobj::PItemIDList aPIDL){ Lmdshcontroller::TLMDShellController::ChDir(aPIDL); }
	inline void __fastcall  ChDir(const System::UnicodeString aPath){ Lmdshcontroller::TLMDShellController::ChDir(aPath); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshfolder */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHFOLDER)
using namespace Lmdshfolder;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshfolderHPP
