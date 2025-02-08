// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysDriveObject.pas' rev: 31.00 (Windows)

#ifndef LmdsysdriveobjectHPP
#define LmdsysdriveobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDSysObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysdriveobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysDriveObject;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysDriveType : unsigned char { dtUnknown, dtNoRootDir, dtFloppy, dtFixed, dtNetwork, dtCDROM, dtRAM };

enum DECLSPEC_DENUM TLMDSysFileSystemOption : unsigned char { fsCaseIsPreserved, fsCaseSensitive, fsSupportsUnicode, fsPersistentACLs, fsSupportsCompression, fsIsCompressed, fsSupportsQuotas };

typedef System::Set<TLMDSysFileSystemOption, TLMDSysFileSystemOption::fsCaseIsPreserved, TLMDSysFileSystemOption::fsSupportsQuotas> TLMDSysFileSystemOptions;

class PASCALIMPLEMENTATION TLMDSysDriveObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	TLMDSysDriveType FDriveType;
	System::WideChar FDrive;
	System::UnicodeString FFileSystem;
	System::UnicodeString FSerialNumber;
	System::UnicodeString FVolumeLabel;
	__int64 FDiskSize;
	__int64 FDiskFree;
	unsigned FSectorsPerCluster;
	unsigned FBytesPerSector;
	unsigned FMaximumLength;
	TLMDSysFileSystemOptions FOptions;
	void __fastcall SetDrive(System::WideChar aValue);
	void __fastcall SetDummyDriveType(TLMDSysDriveType aValue);
	void __fastcall SetDummyDWord(unsigned aValue);
	void __fastcall SetDummyInt64(__int64 aValue);
	void __fastcall SetDummyString(const System::UnicodeString aValue);
	void __fastcall SetDummyOptions(TLMDSysFileSystemOptions aValue);
	void __fastcall SetVolumeLabel(const System::UnicodeString aValue);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall virtual TLMDSysDriveObject(void);
	virtual void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	System::UnicodeString __fastcall DriveTypeStr(TLMDSysDriveType aValue);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	
__published:
	__property unsigned BytesPerSector = {read=FBytesPerSector, write=SetDummyDWord, nodefault};
	__property __int64 DiskSize = {read=FDiskSize, write=SetDummyInt64};
	__property __int64 DiskFree = {read=FDiskFree, write=SetDummyInt64};
	__property System::WideChar Drive = {read=FDrive, write=SetDrive, nodefault};
	__property TLMDSysDriveType DriveType = {read=FDriveType, write=SetDummyDriveType, nodefault};
	__property System::UnicodeString FileSystem = {read=FFileSystem, write=SetDummyString};
	__property unsigned SectorsPerCluster = {read=FSectorsPerCluster, write=SetDummyDWord, nodefault};
	__property unsigned MaximumLength = {read=FMaximumLength, write=SetDummyDWord, nodefault};
	__property System::UnicodeString SerialNumber = {read=FSerialNumber, write=SetDummyString};
	__property TLMDSysFileSystemOptions Options = {read=FOptions, write=SetDummyOptions, nodefault};
	__property System::UnicodeString VolumeLabel = {read=FVolumeLabel, write=SetVolumeLabel};
public:
	/* TLMDSysObject.Destroy */ inline __fastcall virtual ~TLMDSysDriveObject(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSysDriveOptionsToStr(TLMDSysFileSystemOptions aOptions);
}	/* namespace Lmdsysdriveobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSDRIVEOBJECT)
using namespace Lmdsysdriveobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysdriveobjectHPP
