// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysDriveInfo.pas' rev: 31.00 (Windows)

#ifndef LmdsysdriveinfoHPP
#define LmdsysdriveinfoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysDriveObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysdriveinfo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysDriveItem;
class DELPHICLASS TLMDSysDrivesInfo;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysDriveItem : public Lmdsysobject::TLMDSysCollectionItem
{
	typedef Lmdsysobject::TLMDSysCollectionItem inherited;
	
private:
	Lmdsysdriveobject::TLMDSysDriveType FDriveType;
	System::WideChar FDrive;
	System::UnicodeString FFileSystem;
	System::UnicodeString FSerialNumber;
	System::UnicodeString FVolumeLabel;
	__int64 FDiskSize;
	__int64 FDiskFree;
	unsigned FSectorsPerCluster;
	unsigned FBytesPerSector;
	unsigned FMaximumLength;
	Lmdsysdriveobject::TLMDSysFileSystemOptions FOptions;
	void __fastcall SetDrive(System::WideChar aValue);
	void __fastcall SetDummyDriveType(Lmdsysdriveobject::TLMDSysDriveType aValue);
	void __fastcall SetDummyDWord(unsigned aValue);
	void __fastcall SetDummyInt64(__int64 aValue);
	void __fastcall SetDummyString(const System::UnicodeString aValue);
	void __fastcall SetDummyOptions(Lmdsysdriveobject::TLMDSysFileSystemOptions aValue);
	void __fastcall SetVolumeLabel(const System::UnicodeString aValue);
	System::UnicodeString __fastcall DriveTypeToStr(Lmdsysdriveobject::TLMDSysDriveType aValue);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall virtual TLMDSysDriveItem(System::Classes::TCollection* Collection);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property unsigned BytesPerSector = {read=FBytesPerSector, write=SetDummyDWord, stored=false, nodefault};
	__property __int64 DiskSize = {read=FDiskSize, write=SetDummyInt64, stored=false};
	__property __int64 DiskFree = {read=FDiskFree, write=SetDummyInt64, stored=false};
	__property System::WideChar Drive = {read=FDrive, write=SetDrive, stored=false, nodefault};
	__property Lmdsysdriveobject::TLMDSysDriveType DriveType = {read=FDriveType, write=SetDummyDriveType, stored=false, nodefault};
	__property System::UnicodeString FileSystem = {read=FFileSystem, write=SetDummyString, stored=false};
	__property unsigned SectorsPerCluster = {read=FSectorsPerCluster, write=SetDummyDWord, stored=false, nodefault};
	__property unsigned MaximumLength = {read=FMaximumLength, write=SetDummyDWord, stored=false, nodefault};
	__property System::UnicodeString SerialNumber = {read=FSerialNumber, write=SetDummyString, stored=false};
	__property Lmdsysdriveobject::TLMDSysFileSystemOptions Options = {read=FOptions, write=SetDummyOptions, stored=false, nodefault};
	__property System::UnicodeString VolumeLabel = {read=FVolumeLabel, write=SetVolumeLabel, stored=false};
public:
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDSysDriveItem(void) { }
	
};


class PASCALIMPLEMENTATION TLMDSysDrivesInfo : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDSysDriveItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TComponent* FOwner;
	HIDESBASE TLMDSysDriveItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDSysDriveItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDSysDriveItem* __fastcall Add(void);
	__fastcall TLMDSysDrivesInfo(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDSysDrivesInfo(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property TLMDSysDriveItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysdriveinfo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSDRIVEINFO)
using namespace Lmdsysdriveinfo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysdriveinfoHPP
