// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBevel.pas' rev: 31.00 (Windows)

#ifndef LmdbevelHPP
#define LmdbevelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <LMDGraph.hpp>
#include <LMDObject.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbevel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBevel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBevel : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	Lmdgraph::TLMDBevelStyle FBevelStyleInner;
	Lmdgraph::TLMDBevelStyle FBevelStyleOuter;
	Lmdgraph::TLMDBevelWidth FBevelWidthInner;
	Lmdgraph::TLMDBevelWidth FBevelWidthOuter;
	System::Uitypes::TColor FBorderColor;
	Lmdgraph::TLMDBorderWidth FBorderSpace;
	Lmdgraph::TLMDBorderWidth FBorderWidth;
	Lmdgraph::TLMDFrameSides FBorderSides;
	Lmdgraph::TLMDEdgeStyle FEdgeStyle;
	int FExt;
	int FExtr;
	System::Uitypes::TColor FLightColor;
	Lmdgraph::TLMDBevelMode FMode;
	System::Uitypes::TColor FShadowColor;
	Lmdgraph::TLMDBorderStyle FStyle;
	bool FSupport;
	bool FModeChanging;
	void __fastcall SetBevelStyleInner(Lmdgraph::TLMDBevelStyle aValue);
	void __fastcall SetBevelStyleOuter(Lmdgraph::TLMDBevelStyle aValue);
	void __fastcall SetBevelWidthInner(Lmdgraph::TLMDBevelWidth aValue);
	void __fastcall SetBevelWidthOuter(Lmdgraph::TLMDBevelWidth aValue);
	void __fastcall SetColor(int Index, System::Uitypes::TColor aValue);
	void __fastcall SetBorderWidth(Lmdgraph::TLMDBorderWidth aValue);
	void __fastcall SetBorderSides(Lmdgraph::TLMDFrameSides aValue);
	void __fastcall SetBorderSpace(Lmdgraph::TLMDBorderWidth aValue);
	void __fastcall SetEdgeStyle(Lmdgraph::TLMDEdgeStyle aValue);
	void __fastcall SetMode(Lmdgraph::TLMDBevelMode aValue);
	void __fastcall SetStyle(Lmdgraph::TLMDBorderStyle aValue);
	int __fastcall GetBevelExtend(void);
	
protected:
	DYNAMIC void __fastcall Change(void);
	
public:
	__fastcall virtual TLMDBevel(System::Classes::TPersistent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC System::UnicodeString __fastcall GetSetStr(void);
	System::Types::TRect __fastcall ClientRect(const System::Types::TRect &ControlRect);
	virtual System::Types::TRect __fastcall PaintBevel(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, bool Transparent);
	__property int BevelExtend = {read=FExt, nodefault};
	__property int BevelExtendRight = {read=FExtr, nodefault};
	__property bool SupportWindowsMode = {read=FSupport, write=FSupport, nodefault};
	__property bool ModeChanging = {read=FModeChanging, nodefault};
	
__published:
	__property Lmdgraph::TLMDBevelStyle StyleInner = {read=FBevelStyleInner, write=SetBevelStyleInner, default=0};
	__property Lmdgraph::TLMDBevelStyle StyleOuter = {read=FBevelStyleOuter, write=SetBevelStyleOuter, default=0};
	__property Lmdgraph::TLMDBevelWidth WidthInner = {read=FBevelWidthInner, write=SetBevelWidthInner, default=1};
	__property Lmdgraph::TLMDBevelWidth WidthOuter = {read=FBevelWidthOuter, write=SetBevelWidthOuter, default=1};
	__property System::Uitypes::TColor BorderColor = {read=FBorderColor, write=SetColor, index=0, default=-16777201};
	__property Lmdgraph::TLMDFrameSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property Lmdgraph::TLMDBorderWidth BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=0};
	__property Lmdgraph::TLMDBorderWidth BorderInnerWidth = {read=FBorderSpace, write=SetBorderSpace, default=0};
	__property Lmdgraph::TLMDEdgeStyle EdgeStyle = {read=FEdgeStyle, write=SetEdgeStyle, default=5};
	__property System::Uitypes::TColor LightColor = {read=FLightColor, write=SetColor, index=1, default=-16777196};
	__property Lmdgraph::TLMDBevelMode Mode = {read=FMode, write=SetMode, nodefault};
	__property System::Uitypes::TColor ShadowColor = {read=FShadowColor, write=SetColor, index=2, default=-16777200};
	__property Lmdgraph::TLMDBorderStyle StandardStyle = {read=FStyle, write=SetStyle, default=12};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDBevel(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbevel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBEVEL)
using namespace Lmdbevel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbevelHPP
