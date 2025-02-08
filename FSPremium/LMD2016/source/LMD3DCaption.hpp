// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMD3DCaption.pas' rev: 31.00 (Windows)

#ifndef Lmd3dcaptionHPP
#define Lmd3dcaptionHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDGraph.hpp>
#include <LMDObject.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmd3dcaption
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMD3DCaption;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMD3DCaption : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	void __fastcall SetDepth(int Index, System::Byte aValue);
	void __fastcall SetDisabledStyle(Lmdgraph::TLMDDisabledStyle aValue);
	void __fastcall SetColor(int Index, System::Uitypes::TColor aValue);
	void __fastcall SetStyle(Lmdgraph::TLMDThreeDStyle aValue);
	void __fastcall SetOrientation(Lmdgraph::TLMDThreeDOrientation aValue);
	void __fastcall SetTracing(int aValue);
	
protected:
	Lmdgraph::TLMDDisabledStyle FDisabledStyle;
	System::Byte FLightDepth;
	System::Byte FShadowDepth;
	System::Uitypes::TColor FLightColor;
	System::Uitypes::TColor FShadowColor;
	Lmdgraph::TLMDThreeDStyle FStyle;
	Lmdgraph::TLMDThreeDOrientation FOrientation;
	int FTracing;
	
public:
	__fastcall virtual TLMD3DCaption(System::Classes::TPersistent* Owner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC System::UnicodeString __fastcall GetSetStr(void);
	
__published:
	__property Lmdgraph::TLMDDisabledStyle DisabledStyle = {read=FDisabledStyle, write=SetDisabledStyle, default=0};
	__property System::Byte LightDepth = {read=FLightDepth, write=SetDepth, index=0, default=1};
	__property System::Byte ShadowDepth = {read=FShadowDepth, write=SetDepth, index=1, default=1};
	__property System::Uitypes::TColor LightColor = {read=FLightColor, write=SetColor, index=0, default=-16777196};
	__property Lmdgraph::TLMDThreeDOrientation Orientation = {read=FOrientation, write=SetOrientation, default=2};
	__property System::Uitypes::TColor ShadowColor = {read=FShadowColor, write=SetColor, index=1, default=-16777200};
	__property Lmdgraph::TLMDThreeDStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property int Tracing = {read=FTracing, write=SetTracing, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMD3DCaption(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmd3dcaption */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMD3DCAPTION)
using namespace Lmd3dcaption;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Lmd3dcaptionHPP
