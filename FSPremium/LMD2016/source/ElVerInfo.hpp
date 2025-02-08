// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElVerInfo.pas' rev: 31.00 (Windows)

#ifndef ElverinfoHPP
#define ElverinfoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <ElComponent.hpp>
#include <LMDProcs.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.ShellAPI.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elverinfo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElVersionInfo;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TVersionAttribute : unsigned char { vaDebug, vaPatched, vaPreRelease, vaPrivateBuild, vaSpecialBuild };

typedef System::Set<TVersionAttribute, TVersionAttribute::vaDebug, TVersionAttribute::vaSpecialBuild> TVersionAttributes;

class PASCALIMPLEMENTATION TElVersionInfo : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
public:
	Lmdtypes::TLMDString operator[](const Lmdtypes::TLMDString Name) { return this->Values[Name]; }
	
private:
	Lmdtypes::TLMDString FBuffer;
	Lmdtypes::TLMDString FFileName;
	tagVS_FIXEDFILEINFO *FFixedFileInfo;
	Lmdtypes::TLMDString FLanguage;
	TVersionAttributes __fastcall GetAttributes(void);
	int __fastcall GetBuild(void);
	Lmdtypes::TLMDString __fastcall GetLanguage(void);
	int __fastcall GetMajorVersion(void);
	int __fastcall GetMinorVersion(void);
	Lmdtypes::TLMDString __fastcall GetPredefined(int Index);
	int __fastcall GetRelease(void);
	Lmdtypes::TLMDString __fastcall GetValue(const Lmdtypes::TLMDString AName);
	bool __fastcall GetIsVerinfoExists(void);
	void __fastcall SetAttributes(const TVersionAttributes Value);
	void __fastcall SetDummyEx(int Index, const Lmdtypes::TLMDString Value);
	void __fastcall SetFileName(const Lmdtypes::TLMDString Value);
	void __fastcall SetDummyInt(const int Value);
	bool __fastcall StoreFileName(void);
	void __fastcall SetLanguage(const Lmdtypes::TLMDString Value);
	
public:
	__fastcall virtual TElVersionInfo(System::Classes::TComponent* AOwner);
	void __fastcall Refresh(void);
	__property Lmdtypes::TLMDString Values[const Lmdtypes::TLMDString Name] = {read=GetValue/*, default*/};
	
__published:
	__property bool IsVerinfoExists = {read=GetIsVerinfoExists, stored=false, nodefault};
	__property TVersionAttributes Attributes = {read=GetAttributes, write=SetAttributes, stored=false, nodefault};
	__property int Build = {read=GetBuild, write=SetDummyInt, stored=false, nodefault};
	__property Lmdtypes::TLMDString Comments = {read=GetPredefined, write=SetDummyEx, stored=false, index=9};
	__property Lmdtypes::TLMDString CompanyName = {read=GetPredefined, write=SetDummyEx, stored=false, index=0};
	__property Lmdtypes::TLMDString FileDescription = {read=GetPredefined, write=SetDummyEx, stored=false, index=1};
	__property Lmdtypes::TLMDString FileName = {read=FFileName, write=SetFileName, stored=StoreFileName};
	__property Lmdtypes::TLMDString FileVersion = {read=GetPredefined, write=SetDummyEx, stored=false, index=2};
	__property Lmdtypes::TLMDString InternalName = {read=GetPredefined, write=SetDummyEx, stored=false, index=3};
	__property Lmdtypes::TLMDString Language = {read=GetLanguage, write=SetLanguage, stored=false};
	__property Lmdtypes::TLMDString LegalCopyright = {read=GetPredefined, write=SetDummyEx, stored=false, index=4};
	__property Lmdtypes::TLMDString LegalTrademarks = {read=GetPredefined, write=SetDummyEx, stored=false, index=5};
	__property int MajorVersion = {read=GetMajorVersion, write=SetDummyInt, stored=false, nodefault};
	__property int MinorVersion = {read=GetMinorVersion, write=SetDummyInt, stored=false, nodefault};
	__property Lmdtypes::TLMDString OriginalFilename = {read=GetPredefined, write=SetDummyEx, stored=false, index=6};
	__property Lmdtypes::TLMDString ProductName = {read=GetPredefined, write=SetDummyEx, stored=false, index=7};
	__property Lmdtypes::TLMDString ProductVersion = {read=GetPredefined, write=SetDummyEx, stored=false, index=8};
	__property int Release = {read=GetRelease, write=SetDummyInt, stored=false, nodefault};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TElVersionInfo(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elverinfo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELVERINFO)
using namespace Elverinfo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElverinfoHPP
