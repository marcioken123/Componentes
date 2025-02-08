// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPNGImageFilters.pas' rev: 31.00 (Windows)

#ifndef LmdpngimagefiltersHPP
#define LmdpngimagefiltersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDPNGImage.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdpngimagefilters
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPNGImageFilter;
class DELPHICLASS TLMDPNGGrayscaleFilter;
class DELPHICLASS TLMDPNGAlphaBlendFilter;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPNGImageFilter : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdpngimage::TLMDPNGObject* FSourceImage;
	Lmdpngimage::TLMDPNGObject* FResultImage;
	bool FModified;
	void __fastcall SetSourceImage(Lmdpngimage::TLMDPNGObject* const Value);
	Lmdpngimage::TLMDPNGObject* __fastcall GetResultImage(void);
	
protected:
	virtual void __fastcall Transform(void) = 0 ;
	
public:
	__fastcall virtual TLMDPNGImageFilter(void);
	__fastcall virtual ~TLMDPNGImageFilter(void);
	__property Lmdpngimage::TLMDPNGObject* ResultImage = {read=GetResultImage};
	__property Lmdpngimage::TLMDPNGObject* SourceImage = {read=FSourceImage, write=SetSourceImage};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPNGGrayscaleFilter : public TLMDPNGImageFilter
{
	typedef TLMDPNGImageFilter inherited;
	
protected:
	virtual void __fastcall Transform(void);
public:
	/* TLMDPNGImageFilter.Create */ inline __fastcall virtual TLMDPNGGrayscaleFilter(void) : TLMDPNGImageFilter() { }
	/* TLMDPNGImageFilter.Destroy */ inline __fastcall virtual ~TLMDPNGGrayscaleFilter(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPNGAlphaBlendFilter : public TLMDPNGImageFilter
{
	typedef TLMDPNGImageFilter inherited;
	
private:
	System::Byte FAlpha;
	void __fastcall SetAlpha(const System::Byte Value);
	
protected:
	virtual void __fastcall Transform(void);
	
public:
	__fastcall virtual TLMDPNGAlphaBlendFilter(void);
	__property System::Byte AlphaPercent = {read=FAlpha, write=SetAlpha, nodefault};
public:
	/* TLMDPNGImageFilter.Destroy */ inline __fastcall virtual ~TLMDPNGAlphaBlendFilter(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdpngimagefilters */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPNGIMAGEFILTERS)
using namespace Lmdpngimagefilters;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdpngimagefiltersHPP
