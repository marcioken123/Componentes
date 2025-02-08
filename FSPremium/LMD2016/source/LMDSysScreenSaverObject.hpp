// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysScreenSaverObject.pas' rev: 31.00 (Windows)

#ifndef LmdsysscreensaverobjectHPP
#define LmdsysscreensaverobjectHPP

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

//-- user supplied -----------------------------------------------------------

namespace Lmdsysscreensaverobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysScreenSaverObject;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysScreenSaverObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	bool FSecure;
	bool FRunning;
	bool FScreenSaverActive;
	unsigned FScreenSaverDelay;
	System::UnicodeString FExeName;
	System::Classes::TStrings* FScreenSavers;
	NativeUInt FPreviewProcess;
	void __fastcall SetDummyBool(int index, bool aValue);
	void __fastcall SetDummyCardinal(unsigned aValue);
	void __fastcall SetDummyStrings(System::Classes::TStrings* aValue);
	void __fastcall SetString(System::UnicodeString aValue);
	bool __fastcall GetBool(int index);
	unsigned __fastcall GetCardinal(void);
	System::Classes::TStrings* __fastcall GetStrings(void);
	System::UnicodeString __fastcall GetString(void);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall virtual TLMDSysScreenSaverObject(void);
	__fastcall virtual ~TLMDSysScreenSaverObject(void);
	virtual void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	void __fastcall Test(void);
	void __fastcall Config(void);
	void __fastcall Preview(HWND aWndHandle);
	void __fastcall StopPreview(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property bool Active = {read=GetBool, write=SetDummyBool, stored=false, index=0, nodefault};
	__property unsigned Delay = {read=GetCardinal, write=SetDummyCardinal, stored=false, nodefault};
	__property bool Secure = {read=GetBool, write=SetDummyBool, stored=false, index=1, nodefault};
	__property bool Running = {read=GetBool, write=SetDummyBool, stored=false, index=2, nodefault};
	__property System::UnicodeString ScreenSaver = {read=GetString, write=SetString, stored=false};
	__property System::Classes::TStrings* ScreenSavers = {read=GetStrings, write=SetDummyStrings, stored=false};
};


typedef System::TMetaClass* TLMDSysScreenSaverObjectClass;

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysscreensaverobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSSCREENSAVEROBJECT)
using namespace Lmdsysscreensaverobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysscreensaverobjectHPP
