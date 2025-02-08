// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysKeyboardObject.pas' rev: 31.00 (Windows)

#ifndef LmdsyskeyboardobjectHPP
#define LmdsyskeyboardobjectHPP

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
#include <LMDSysBase.hpp>
#include <LMDSysConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsyskeyboardobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysKeyboardObject;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysKeyboardDisplayInfo : unsigned char { kpidTypeString, kpidType, kpidSubType, kpidFunctionKeys, kpidDelay, kpidSpeed, kpidNumLock, kpidCapsLock, kpidScrollLock, kpidCaretBlinkTime, kpidLayout };

typedef System::Set<TLMDSysKeyboardDisplayInfo, TLMDSysKeyboardDisplayInfo::kpidTypeString, TLMDSysKeyboardDisplayInfo::kpidLayout> TLMDSysKeyboardDisplayInfos;

typedef System::StaticArray<Lmdsysbase::TLMDSysProperty, 11> Lmdsyskeyboardobject__1;

typedef System::StaticArray<System::UnicodeString, 7> Lmdsyskeyboardobject__2;

class PASCALIMPLEMENTATION TLMDSysKeyboardObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	int FCaretBlinkTime;
	int FKeyboardSpeed;
	int FKeyboardDelay;
	bool FNumLock;
	bool FCapsLock;
	bool FScroll;
	int FType;
	int FSubType;
	int FFuncKeys;
	System::UnicodeString FLayout;
	TLMDSysKeyboardDisplayInfos FDisplayInfo;
	void __fastcall SetDummyBool(int index, bool aValue);
	void __fastcall SetDummyInteger(int index, int aValue);
	void __fastcall SetDummyString(System::UnicodeString aValue);
	bool __fastcall getNumLock(void);
	bool __fastcall getCapsLock(void);
	bool __fastcall getScrollLock(void);
	System::UnicodeString __fastcall getLayout(void);
	bool __fastcall GetBool(int index);
	int __fastcall GetKeyboardDelay(void);
	int __fastcall GetKeyboardSpeed(void);
	int __fastcall GetCaretBlinkTime(void);
	int __fastcall GetInteger(int index);
	System::UnicodeString __fastcall GetLayoutStr(void);
	void __fastcall SetCaretBlinkTime(const int Value);
	void __fastcall SetKeyboardDelay(const int Value);
	void __fastcall SetKeyboardSpeed(const int Value);
	void __fastcall SetDisplayInfo(const TLMDSysKeyboardDisplayInfos Value);
	System::UnicodeString __fastcall GetKeyboardString(void);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall virtual TLMDSysKeyboardObject(void);
	virtual void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property System::UnicodeString TypeString = {read=GetKeyboardString, write=SetDummyString, stored=false};
	__property int Delay = {read=GetKeyboardDelay, write=SetKeyboardDelay, stored=false, nodefault};
	__property int Speed = {read=GetKeyboardSpeed, write=SetKeyboardSpeed, stored=false, nodefault};
	__property bool NumLock = {read=GetBool, write=SetDummyBool, stored=false, index=0, nodefault};
	__property bool CapsLock = {read=GetBool, write=SetDummyBool, stored=false, index=1, nodefault};
	__property int CaretBlinkTime = {read=GetCaretBlinkTime, write=SetCaretBlinkTime, stored=false, nodefault};
	__property bool ScrollLock = {read=GetBool, write=SetDummyBool, stored=false, index=2, nodefault};
	__property int TypeID = {read=GetInteger, write=SetDummyInteger, stored=false, index=0, nodefault};
	__property int SubTypeID = {read=GetInteger, write=SetDummyInteger, stored=false, index=1, nodefault};
	__property int FunctionKeys = {read=GetInteger, write=SetDummyInteger, stored=false, index=2, nodefault};
	__property System::UnicodeString Layout = {read=GetLayoutStr, write=SetDummyString, stored=false};
	__property TLMDSysKeyboardDisplayInfos DisplayInfo = {read=FDisplayInfo, write=SetDisplayInfo, default=2047};
public:
	/* TLMDSysObject.Destroy */ inline __fastcall virtual ~TLMDSysKeyboardObject(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define def_TLMDSysKeyboardDisplayInfos (System::Set<TLMDSysKeyboardDisplayInfo, TLMDSysKeyboardDisplayInfo::kpidTypeString, TLMDSysKeyboardDisplayInfo::kpidLayout>() << TLMDSysKeyboardDisplayInfo::kpidTypeString << TLMDSysKeyboardDisplayInfo::kpidType << TLMDSysKeyboardDisplayInfo::kpidSubType << TLMDSysKeyboardDisplayInfo::kpidFunctionKeys << TLMDSysKeyboardDisplayInfo::kpidDelay << TLMDSysKeyboardDisplayInfo::kpidSpeed << TLMDSysKeyboardDisplayInfo::kpidNumLock << TLMDSysKeyboardDisplayInfo::kpidCapsLock << TLMDSysKeyboardDisplayInfo::kpidScrollLock << TLMDSysKeyboardDisplayInfo::kpidCaretBlinkTime << TLMDSysKeyboardDisplayInfo::kpidLayout )
extern DELPHI_PACKAGE Lmdsyskeyboardobject__1 LMDSysKeyboardProps;
extern DELPHI_PACKAGE Lmdsyskeyboardobject__2 LMDSysKeyboardNames;
}	/* namespace Lmdsyskeyboardobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSKEYBOARDOBJECT)
using namespace Lmdsyskeyboardobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsyskeyboardobjectHPP
