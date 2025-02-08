// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextObject.pas' rev: 31.00 (Windows)

#ifndef LmdtextobjectHPP
#define LmdtextobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <LMDObject.hpp>
#include <LMDParser.hpp>
#include <LMDText.hpp>
#include <LMDProcs.hpp>
#include <LMDButtonBase.hpp>
#include <LMDButtonLayout.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMD3DCaption.hpp>
#include <LMDGraph.hpp>
#include <LMDUtils.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDHTMLParser.hpp>
#include <LMDPlainTextParser.hpp>
#include <LMDSimpleXMLParser.hpp>
#include <LMDDBFParser.hpp>
#include <LMDCSVParser.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextObject;
class DELPHICLASS TLMDStrings;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDLinkClickEvent)(System::Uitypes::TMouseButton Button, System::Classes::TShiftState aShift, const System::UnicodeString aLinkText);

class PASCALIMPLEMENTATION TLMDTextObject : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	Lmdparser::TLMDParser* FParser;
	Lmdtext::TLMDParsedTextList* FParsedText;
	bool FEnabled;
	System::Types::TPoint FOffset;
	Vcl::Controls::TControl* FOwnerControl;
	Vcl::Controls::TWinControl* FParentControl;
	System::Classes::TNotifyEvent FOnBeforeParse;
	System::Classes::TNotifyEvent FOnAfterParse;
	TLMDLinkClickEvent FOnLinkClick;
	Lmdtext::TLMDGraphicErrorEvent FOnGraphicError;
	Lmdtext::TLMDGetVariableEvent FOnGetVariable;
	Lmdtext::TLMDEmbdControlEvent FOnControlCreated;
	Lmdtext::TLMDRepeatEvent FOnRepeat;
	bool FForceChange;
	bool __fastcall IsNotDefault(void);
	System::UnicodeString __fastcall GetParserClass(void);
	void __fastcall SetParserClass(const System::UnicodeString Value);
	
protected:
	DYNAMIC void __fastcall DoBeforeParse(void);
	DYNAMIC void __fastcall DoAfterParse(void);
	void __fastcall DoLinkClick(System::Uitypes::TMouseButton aButton, System::Classes::TShiftState aShift, const System::UnicodeString aLinkText);
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	
public:
	void __fastcall MouseDown(Vcl::Controls::TControl* aControl, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y, bool autoSize, bool wordWrap, Vcl::Graphics::TFont* aFont, Vcl::Graphics::TCanvas* aCanvas);
	void __fastcall MouseMove(Vcl::Controls::TControl* aControl, System::Classes::TShiftState Shift, int X, int Y, bool autoSize, bool wordWrap, Vcl::Graphics::TFont* aFont, Vcl::Graphics::TCanvas* aCanvas);
	virtual void __fastcall Parse(System::Classes::TStream* M)/* overload */;
	void __fastcall Parse(const System::UnicodeString S)/* overload */;
	void __fastcall Parse(System::Classes::TStrings* aLines)/* overload */;
	virtual Vcl::Graphics::TBitmap* __fastcall Render(const System::Types::TRect &aRect, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap)/* overload */;
	void __fastcall Render3D(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, const System::Types::TPoint &aOffset, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap, Lmd3dcaption::TLMD3DCaption* Effects, Lmdgraph::TLMDDrawTextStyles ExtFlags);
	void __fastcall Render(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, const System::Types::TPoint &aOffset, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap)/* overload */;
	Lmdgraphutils::TLMDWhereRect __fastcall Render(Vcl::Graphics::TCanvas* aCanvas, Lmd3dcaption::TLMD3DCaption* Effects, Vcl::Graphics::TFont* aDefFont, const System::Types::TRect &aDest, Vcl::Graphics::TCanvas* srcCanvas, System::Types::TRect &srcRect, Vcl::Graphics::TCanvas* aMaskCanvas, System::Uitypes::TColor aBkColor, System::Uitypes::TColor TransColor, Lmdglyphtextlayout::TLMDGlyphTextLayout* aLayout, bool autoSize, bool wordwrap, bool Transparent, Lmdgraph::TLMDDrawTextStyles ExtFlags, int flags)/* overload */;
	void __fastcall ParseAndRender(const System::UnicodeString s, Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, const System::Types::TPoint &aOffset, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap);
	System::Types::TRect __fastcall GetClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	__fastcall virtual TLMDTextObject(System::Classes::TPersistent* Owner)/* overload */;
	__fastcall TLMDTextObject(bool ForceChange)/* overload */;
	__fastcall TLMDTextObject(Vcl::Controls::TControl* Owner, Vcl::Controls::TWinControl* Parent);
	__fastcall virtual ~TLMDTextObject(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property Vcl::Controls::TWinControl* Parent = {read=FParentControl, write=FParentControl, stored=false};
	__property Lmdtext::TLMDParsedTextList* ParsedText = {read=FParsedText};
	__property System::Classes::TNotifyEvent OnBeforeParse = {read=FOnBeforeParse, write=FOnBeforeParse};
	__property System::Classes::TNotifyEvent OnAfterParse = {read=FOnAfterParse, write=FOnAfterParse};
	__property TLMDLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Lmdtext::TLMDGraphicErrorEvent OnGraphicError = {read=FOnGraphicError, write=FOnGraphicError};
	__property Lmdtext::TLMDGetVariableEvent OnGetVariable = {read=FOnGetVariable, write=FOnGetVariable};
	__property Lmdtext::TLMDRepeatEvent OnRepeat = {read=FOnRepeat, write=FOnRepeat};
	__property Lmdtext::TLMDEmbdControlEvent OnControlCreated = {read=FOnControlCreated, write=FOnControlCreated};
	
__published:
	__property System::UnicodeString ParserClass = {read=GetParserClass, write=SetParserClass, stored=IsNotDefault};
};


class PASCALIMPLEMENTATION TLMDStrings : public System::Classes::TStringList
{
	typedef System::Classes::TStringList inherited;
	
private:
	bool FLoading;
	
public:
	__fastcall TLMDStrings(void);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream)/* overload */;
public:
	/* TStringList.Destroy */ inline __fastcall virtual ~TLMDStrings(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  LoadFromStream(System::Classes::TStream* Stream, System::Sysutils::TEncoding* Encoding){ System::Classes::TStrings::LoadFromStream(Stream, Encoding); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTOBJECT)
using namespace Lmdtextobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextobjectHPP
