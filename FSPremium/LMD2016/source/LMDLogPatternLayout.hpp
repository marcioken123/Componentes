// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLogPatternLayout.pas' rev: 31.00 (Windows)

#ifndef LmdlogpatternlayoutHPP
#define LmdlogpatternlayoutHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDLogLayoutTransport.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDStrings.hpp>
#include <LMDLogMessage.hpp>
#include <LMDTypes.hpp>
#include <LMDLogFileTransport.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlogpatternlayout
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLogPatternLayout;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLogPatternLayout : public Lmdloglayouttransport::TLMDLogCustomTextLayout
{
	typedef Lmdloglayouttransport::TLMDLogCustomTextLayout inherited;
	
private:
	Lmdtypes::TLMDString FPattern;
	bool FIndent;
	
protected:
	virtual void __fastcall SetParameters(System::Classes::TStringList* const AStr);
	virtual System::WideString __fastcall GetParameters(void);
	Lmdtypes::TLMDString __fastcall ApplyPattern(Lmdlogmessage::TLMDLogMessage* const AMessage);
	
public:
	__classmethod virtual System::WideString __fastcall GetName();
	virtual Lmdtypes::TLMDString __fastcall GetMessageAsText(Lmdlogmessage::TLMDLogMessage* const AMessage);
	virtual Lmdtypes::TLMDString __fastcall GetHeaderAsText(void);
	virtual Lmdtypes::TLMDString __fastcall GetFooterAsText(void);
	__property Lmdtypes::TLMDString Pattern = {read=FPattern, write=FPattern};
	__property bool Indent = {read=FIndent, write=FIndent, nodefault};
public:
	/* TLMDLogCustomLayout.Create */ inline __fastcall virtual TLMDLogPatternLayout(void) : Lmdloglayouttransport::TLMDLogCustomTextLayout() { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDLogPatternLayout(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlogpatternlayout */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLOGPATTERNLAYOUT)
using namespace Lmdlogpatternlayout;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlogpatternlayoutHPP
