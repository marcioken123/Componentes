// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFXCaption.pas' rev: 31.00 (Windows)

#ifndef LmdfxcaptionHPP
#define LmdfxcaptionHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDGraph.hpp>
#include <LMD3DCaption.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfxcaption
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFxCaption;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFxCaption : public Lmd3dcaption::TLMD3DCaption
{
	typedef Lmd3dcaption::TLMD3DCaption inherited;
	
private:
	Lmdgraph::TLMDAngle FAngle;
	System::Word FPosX;
	System::Word FPosY;
	void __fastcall SetAngle(Lmdgraph::TLMDAngle aValue);
	void __fastcall SetPos(int Index, System::Word aValue);
	
public:
	__fastcall virtual TLMDFxCaption(System::Classes::TPersistent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC System::UnicodeString __fastcall GetSetStr(void);
	void __fastcall SetPosXY(System::Word X, System::Word Y);
	
__published:
	__property Lmdgraph::TLMDAngle Angle = {read=FAngle, write=SetAngle, default=0};
	__property System::Word PosX = {read=FPosX, write=SetPos, index=0, default=0};
	__property System::Word PosY = {read=FPosY, write=SetPos, index=1, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDFxCaption(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfxcaption */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFXCAPTION)
using namespace Lmdfxcaption;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfxcaptionHPP
