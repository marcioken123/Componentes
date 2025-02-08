// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysPlusObject.pas' rev: 31.00 (Windows)

#ifndef LmdsysplusobjectHPP
#define LmdsysplusobjectHPP

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

//-- user supplied -----------------------------------------------------------

namespace Lmdsysplusobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysPlusObject;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysPlusObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	bool FAvailable;
	bool FFontSmoothing;
	bool FWindowAnimation;
	bool FDragFullWindows;
	void __fastcall SetBool(int index, bool aValue);
	bool __fastcall GetBool(int index);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall virtual TLMDSysPlusObject(void);
	virtual void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property bool Available = {read=GetBool, write=SetBool, stored=false, index=0, nodefault};
	__property bool FontSmoothing = {read=GetBool, write=SetBool, stored=false, index=1, nodefault};
	__property bool WindowAnimation = {read=GetBool, write=SetBool, stored=false, index=2, nodefault};
	__property bool DragFullWindows = {read=GetBool, write=SetBool, stored=false, index=3, nodefault};
public:
	/* TLMDSysObject.Destroy */ inline __fastcall virtual ~TLMDSysPlusObject(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysplusobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSPLUSOBJECT)
using namespace Lmdsysplusobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysplusobjectHPP
