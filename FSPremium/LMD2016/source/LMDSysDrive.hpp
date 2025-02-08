// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysDrive.pas' rev: 31.00 (Windows)

#ifndef LmdsysdriveHPP
#define LmdsysdriveHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysDriveObject.hpp>
#include <LMDSysDriveInfo.hpp>
#include <LMDSysBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysdrive
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysDrive;
class DELPHICLASS TLMDSysDrives;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysDrive : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsysdriveobject::TLMDSysDriveObject* __fastcall GetObj(void);
	void __fastcall SetObj(Lmdsysdriveobject::TLMDSysDriveObject* aValue);
	
public:
	__fastcall virtual TLMDSysDrive(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdsysdriveobject::TLMDSysDriveObject* Drive = {read=GetObj, write=SetObj, stored=false};
public:
	/* TLMDSysBaseComponent.Destroy */ inline __fastcall virtual ~TLMDSysDrive(void) { }
	
};


class PASCALIMPLEMENTATION TLMDSysDrives : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsysdriveinfo::TLMDSysDrivesInfo* FDrives;
	void __fastcall SetDrives(Lmdsysdriveinfo::TLMDSysDrivesInfo* const Value);
	
protected:
	virtual void __fastcall RefreshIt(void);
	
public:
	__fastcall virtual TLMDSysDrives(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDSysDrives(void);
	virtual int __fastcall GetElementCount(void);
	virtual System::TObject* __fastcall GetElement(int index);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property Lmdsysdriveinfo::TLMDSysDrivesInfo* Drives = {read=FDrives, write=SetDrives, stored=false};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysdrive */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSDRIVE)
using namespace Lmdsysdrive;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysdriveHPP
