// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysMouseObject.pas' rev: 31.00 (Windows)

#ifndef LmdsysmouseobjectHPP
#define LmdsysmouseobjectHPP

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
#include <LMDSysConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysmouseobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysMouseObject;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysMouseDisplayInfo : unsigned char { mpidButtons, mpidSwapButtons, mpidHasWheel, mpidSpeed, mpidDoubleClickTime, mpidDoubleClickWidth, mpidDoubleClickHeight, mpidExist, mpidSnapToDefault, mpidCursorScheme, mpidCursorSchemes };

typedef System::Set<TLMDSysMouseDisplayInfo, TLMDSysMouseDisplayInfo::mpidButtons, TLMDSysMouseDisplayInfo::mpidCursorSchemes> TLMDSysMouseDisplayInfos;

typedef System::StaticArray<Lmdsysbase::TLMDSysProperty, 11> Lmdsysmouseobject__1;

class PASCALIMPLEMENTATION TLMDSysMouseObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	System::Word FBtns;
	System::Word FDoubleClickTime;
	bool FSnapToDefault;
	bool FSwapBtns;
	bool FExist;
	bool FWheel;
	int FSpeed;
	int FDblClickWidth;
	int FDblClickHeight;
	System::Classes::TStrings* FCurSchemeFiles;
	System::Classes::TStrings* FCursorSchemes;
	System::UnicodeString FCursorScheme;
	TLMDSysMouseDisplayInfos FDisplayInfo;
	void __fastcall SetBool(int index, bool aValue);
	void __fastcall SetDisplayInfo(const TLMDSysMouseDisplayInfos Value);
	void __fastcall SetWord(int index, System::Word aValue);
	void __fastcall SetInteger(int index, int aValue);
	void __fastcall SetDummyStrings(System::Classes::TStrings* aValue);
	void __fastcall SetDummyString(System::UnicodeString aValue);
	bool __fastcall GetBool(int index);
	System::Word __fastcall GetWord(int index);
	int __fastcall GetInteger(int index);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall virtual TLMDSysMouseObject(void);
	__fastcall virtual ~TLMDSysMouseObject(void);
	virtual void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property System::Word DoubleClickTime = {read=GetWord, write=SetWord, stored=false, index=0, nodefault};
	__property int DoubleClickWidth = {read=GetInteger, write=SetInteger, stored=false, index=0, nodefault};
	__property int DoubleClickHeight = {read=GetInteger, write=SetInteger, stored=false, index=1, nodefault};
	__property int Speed = {read=GetInteger, write=SetInteger, stored=false, index=2, nodefault};
	__property System::Word Buttons = {read=GetWord, write=SetWord, stored=false, index=1, nodefault};
	__property bool SwapButtons = {read=GetBool, write=SetBool, stored=false, index=0, nodefault};
	__property bool Exist = {read=GetBool, write=SetBool, stored=false, index=1, nodefault};
	__property bool HasWheel = {read=GetBool, write=SetBool, stored=false, index=2, nodefault};
	__property bool SnapToDefault = {read=GetBool, write=SetBool, stored=false, index=3, nodefault};
	__property System::UnicodeString CursorScheme = {read=FCursorScheme, write=SetDummyString, stored=false};
	__property System::Classes::TStrings* CursorSchemes = {read=FCursorSchemes, write=SetDummyStrings, stored=false};
	__property TLMDSysMouseDisplayInfos DisplayInfo = {read=FDisplayInfo, write=SetDisplayInfo, default=2047};
};


//-- var, const, procedure ---------------------------------------------------
#define def_TLMDSysMouseDisplayInfos (System::Set<TLMDSysMouseDisplayInfo, TLMDSysMouseDisplayInfo::mpidButtons, TLMDSysMouseDisplayInfo::mpidCursorSchemes>() << TLMDSysMouseDisplayInfo::mpidButtons << TLMDSysMouseDisplayInfo::mpidSwapButtons << TLMDSysMouseDisplayInfo::mpidHasWheel << TLMDSysMouseDisplayInfo::mpidSpeed << TLMDSysMouseDisplayInfo::mpidDoubleClickTime << TLMDSysMouseDisplayInfo::mpidDoubleClickWidth << TLMDSysMouseDisplayInfo::mpidDoubleClickHeight << TLMDSysMouseDisplayInfo::mpidExist << TLMDSysMouseDisplayInfo::mpidSnapToDefault << TLMDSysMouseDisplayInfo::mpidCursorScheme << TLMDSysMouseDisplayInfo::mpidCursorSchemes )
extern DELPHI_PACKAGE Lmdsysmouseobject__1 LMDSysMouseProps;
}	/* namespace Lmdsysmouseobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSMOUSEOBJECT)
using namespace Lmdsysmouseobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysmouseobjectHPP
