// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDText.pas' rev: 31.00 (Windows)

#ifndef LmdtextHPP
#define LmdtextHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <LMDWriter.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtext
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBaseText;
class DELPHICLASS TLMDParsedTextList;
class DELPHICLASS TLMDParseList;
class DELPHICLASS TLMDRepeat;
class DELPHICLASS TLMDParagraph;
class DELPHICLASS TLMDParseListItem;
class DELPHICLASS TLMDPieceOfText;
class DELPHICLASS TLMDLine;
class DELPHICLASS TLMDLineBreak;
class DELPHICLASS TLMDImage;
class DELPHICLASS TLMDText;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDGraphicErrorEvent)(System::TObject* Sender, Vcl::Graphics::TPicture* aPicture, const System::UnicodeString aFileName, int aImageIndex);

typedef System::UnicodeString __fastcall (__closure *TLMDGetVariableEvent)(System::TObject* Sender, const System::UnicodeString aVarName);

typedef void __fastcall (__closure *TLMDEmbdControlEvent)(System::TObject* Sender, Vcl::Controls::TControl* AControl, const System::UnicodeString AName);

typedef void __fastcall (__closure *TLMDRepeatEvent)(System::TObject* Sender, int aNumber);

typedef System::TMetaClass* TLMDBaseTextClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBaseText : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Types::TPoint FPosInParent;
	TLMDParsedTextList* FParent;
	Vcl::Controls::TWinControl* FParentControl;
	Vcl::Controls::TControl* FOwnerControl;
	bool FPrevAutoSize;
	bool FPrevWordWrap;
	System::UnicodeString FPrevFontName;
	int FPrevFontSize;
	
protected:
	int FClientWidth;
	int FClientHeight;
	virtual bool __fastcall NeedReCalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	virtual void __fastcall CalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap) = 0 ;
	
public:
	__fastcall TLMDBaseText(TLMDParsedTextList* aParent);
	void __fastcall Chop(void);
	virtual void __fastcall Render(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, const System::Types::TPoint &aOffset, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap, bool aMask) = 0 /* overload */;
	virtual TLMDBaseText* __fastcall CheckMousePos(const System::Types::TPoint &aPos, Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	__property System::Types::TPoint PosInParent = {read=FPosInParent, write=FPosInParent};
	System::Types::TRect __fastcall GetClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	virtual TLMDBaseText* __fastcall Clone(void);
	virtual void __fastcall ApplyVariables(TLMDGetVariableEvent aGetVariableEvent);
	virtual void __fastcall Store(Lmdwriter::TLMDWriter* AWriter);
	__property TLMDParsedTextList* Parent = {read=FParent, write=FParent};
	__property Vcl::Controls::TWinControl* ParentControl = {read=FParentControl, write=FParentControl};
	__property Vcl::Controls::TControl* OwnerControl = {read=FOwnerControl, write=FOwnerControl};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBaseText(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDParsedTextList : public TLMDBaseText
{
	typedef TLMDBaseText inherited;
	
public:
	TLMDBaseText* operator[](int aIndex) { return this->SubItem[aIndex]; }
	
private:
	System::Classes::TList* FTextList;
	int __fastcall GetCount(void);
	TLMDBaseText* __fastcall GetSubItem(int aIndex);
	void __fastcall SetSubitem(int aIndex, TLMDBaseText* const Value);
	
protected:
	virtual bool __fastcall NeedReCalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	virtual void __fastcall CalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	
public:
	__fastcall TLMDParsedTextList(TLMDParsedTextList* aParent);
	void __fastcall Clear(void);
	__fastcall virtual ~TLMDParsedTextList(void);
	TLMDBaseText* __fastcall AddSubitem(TLMDBaseText* aSubItem);
	TLMDBaseText* __fastcall InsertSubItem(int aPos, TLMDBaseText* aSubItem);
	virtual void __fastcall Render(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, const System::Types::TPoint &aOffset, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap, bool aMask)/* overload */;
	virtual TLMDBaseText* __fastcall CheckMousePos(const System::Types::TPoint &aPos, Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	virtual void __fastcall ApplyVariables(TLMDGetVariableEvent aGetVariableEvent);
	virtual TLMDBaseText* __fastcall Clone(void);
	virtual void __fastcall Store(Lmdwriter::TLMDWriter* AWriter);
	__property TLMDBaseText* SubItem[int aIndex] = {read=GetSubItem, write=SetSubitem/*, default*/};
	__property int Count = {read=GetCount, nodefault};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDListType : unsigned char { ltUnordered, ltOrdered };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDParseList : public TLMDParsedTextList
{
	typedef TLMDParsedTextList inherited;
	
private:
	TLMDListType FListType;
	int __fastcall GetBulletOffset(int Index);
	
protected:
	virtual bool __fastcall NeedReCalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	virtual void __fastcall CalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	
public:
	__fastcall TLMDParseList(TLMDParsedTextList* aParent)/* overload */;
	__fastcall TLMDParseList(TLMDParsedTextList* aParent, TLMDListType aListType)/* overload */;
	virtual void __fastcall Render(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, const System::Types::TPoint &aOffset, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap, bool aMask)/* overload */;
	virtual TLMDBaseText* __fastcall Clone(void);
	virtual void __fastcall Store(Lmdwriter::TLMDWriter* AWriter);
public:
	/* TLMDParsedTextList.Destroy */ inline __fastcall virtual ~TLMDParseList(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDRepeat : public TLMDParsedTextList
{
	typedef TLMDParsedTextList inherited;
	
private:
	System::UnicodeString FRepeatCount;
	TLMDRepeatEvent FRepeatEvent;
	int __fastcall GetRepeatCount(void);
	
public:
	__fastcall TLMDRepeat(TLMDParsedTextList* aParent)/* overload */;
	__fastcall TLMDRepeat(TLMDParsedTextList* aParent, const System::UnicodeString aRepeatCount)/* overload */;
	__fastcall TLMDRepeat(TLMDParsedTextList* aParent, const System::UnicodeString aRepeatCount, TLMDRepeatEvent aRepeatEvent)/* overload */;
	virtual void __fastcall ApplyVariables(TLMDGetVariableEvent aGetVariableEvent);
	__property int RepeatCount = {read=GetRepeatCount, nodefault};
public:
	/* TLMDParsedTextList.Destroy */ inline __fastcall virtual ~TLMDRepeat(void) { }
	
};


enum DECLSPEC_DENUM TLMDParaAlign : unsigned char { paLeft, paRight, paCenter, paJustify };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDParagraph : public TLMDParsedTextList
{
	typedef TLMDParsedTextList inherited;
	
private:
	System::UnicodeString FAlign;
	TLMDParaAlign __fastcall GetAlign(void);
	
protected:
	virtual bool __fastcall NeedReCalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	virtual void __fastcall CalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	
public:
	__fastcall TLMDParagraph(TLMDParsedTextList* aParent, System::UnicodeString aAlign)/* overload */;
	virtual void __fastcall Render(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, const System::Types::TPoint &aOffset, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap, bool aMask)/* overload */;
	virtual void __fastcall ApplyVariables(TLMDGetVariableEvent aGetVariableEvent);
	__property TLMDParaAlign Align = {read=GetAlign, nodefault};
	__property System::UnicodeString AlignTxt = {read=FAlign, write=FAlign};
	virtual TLMDBaseText* __fastcall Clone(void);
	virtual void __fastcall Store(Lmdwriter::TLMDWriter* AWriter);
public:
	/* TLMDParsedTextList.Destroy */ inline __fastcall virtual ~TLMDParagraph(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDParseListItem : public TLMDParsedTextList
{
	typedef TLMDParsedTextList inherited;
	
public:
	__fastcall TLMDParseListItem(TLMDParsedTextList* aParent);
public:
	/* TLMDParsedTextList.Destroy */ inline __fastcall virtual ~TLMDParseListItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPieceOfText : public TLMDBaseText
{
	typedef TLMDBaseText inherited;
	
private:
	bool FLink;
	System::UnicodeString FHREF;
	
public:
	__fastcall TLMDPieceOfText(TLMDParsedTextList* aParent);
	virtual void __fastcall ApplyVariables(TLMDGetVariableEvent aGetVariableEvent);
	virtual TLMDBaseText* __fastcall Clone(void);
	__property bool Link = {read=FLink, write=FLink, nodefault};
	__property System::UnicodeString HREF = {read=FHREF, write=FHREF};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDPieceOfText(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLine : public TLMDPieceOfText
{
	typedef TLMDPieceOfText inherited;
	
protected:
	virtual bool __fastcall NeedReCalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	virtual void __fastcall CalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	
public:
	virtual void __fastcall Render(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, const System::Types::TPoint &aOffset, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap, bool aMask)/* overload */;
	virtual void __fastcall Store(Lmdwriter::TLMDWriter* AWriter);
public:
	/* TLMDPieceOfText.Create */ inline __fastcall TLMDLine(TLMDParsedTextList* aParent) : TLMDPieceOfText(aParent) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDLine(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLineBreak : public TLMDPieceOfText
{
	typedef TLMDPieceOfText inherited;
	
protected:
	virtual bool __fastcall NeedReCalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	virtual void __fastcall CalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	
public:
	virtual void __fastcall Render(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, const System::Types::TPoint &aOffset, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap, bool aMask)/* overload */;
	virtual void __fastcall Store(Lmdwriter::TLMDWriter* AWriter);
public:
	/* TLMDPieceOfText.Create */ inline __fastcall TLMDLineBreak(TLMDParsedTextList* aParent) : TLMDPieceOfText(aParent) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDLineBreak(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDImage : public TLMDPieceOfText
{
	typedef TLMDPieceOfText inherited;
	
private:
	System::UnicodeString FSrc;
	System::UnicodeString FImageIndex;
	System::UnicodeString FHeight;
	System::UnicodeString FWidth;
	Vcl::Graphics::TPicture* FPicture;
	TLMDGraphicErrorEvent FOnGraphicError;
	int __fastcall GetHeight(void);
	int __fastcall GetImageIndex(void);
	int __fastcall GetWidth(void);
	
protected:
	virtual bool __fastcall NeedReCalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	virtual void __fastcall CalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	
public:
	__fastcall TLMDImage(TLMDParsedTextList* aParent)/* overload */;
	__fastcall TLMDImage(TLMDParsedTextList* aParent, const System::UnicodeString aSrc, const System::UnicodeString aWidth, const System::UnicodeString aHeight, const System::UnicodeString aImageIndex, TLMDGraphicErrorEvent aOnGraphicError)/* overload */;
	__fastcall virtual ~TLMDImage(void);
	virtual void __fastcall Render(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, const System::Types::TPoint &aOffset, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap, bool aMask)/* overload */;
	virtual void __fastcall ApplyVariables(TLMDGetVariableEvent aGetVariableEvent);
	virtual TLMDBaseText* __fastcall Clone(void);
	virtual void __fastcall Store(Lmdwriter::TLMDWriter* AWriter);
	__property System::UnicodeString Src = {read=FSrc};
	__property int Width = {read=GetWidth, nodefault};
	__property int Height = {read=GetHeight, nodefault};
	__property int ImageIndex = {read=GetImageIndex, nodefault};
};


enum DECLSPEC_DENUM TLMDTextSubscriptStyle : unsigned char { tssNone, tssSubscript, tssSuperscript };

enum DECLSPEC_DENUM TLMDTextStyle : unsigned char { tsNormal, tsSunken, tsRaised, tsPColorSunken, tsPColorRaised };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDText : public TLMDPieceOfText
{
	typedef TLMDPieceOfText inherited;
	
private:
	System::UnicodeString FText;
	TLMDTextSubscriptStyle FSubscriptStyle;
	System::UnicodeString FFontFace;
	System::Uitypes::TColor FFontColor;
	System::Uitypes::TColor FShadowColor;
	System::Byte FShadowDepth;
	System::Uitypes::TColor FLightColor;
	System::Byte FLightDepth;
	TLMDTextStyle FTextStyle;
	System::UnicodeString FFontSize;
	System::UnicodeString FBaseFontSize;
	System::Uitypes::TFontStyles FFontStyle;
	bool __fastcall IsEmpty(const System::UnicodeString aText);
	
protected:
	virtual System::UnicodeString __fastcall GetText(void);
	virtual bool __fastcall NeedReCalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	virtual void __fastcall CalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	
public:
	__fastcall TLMDText(TLMDParsedTextList* aParent)/* overload */;
	__fastcall TLMDText(const System::UnicodeString aText, TLMDParsedTextList* aParent)/* overload */;
	virtual void __fastcall Render(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, const System::Types::TPoint &aOffset, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap, bool aMask)/* overload */;
	virtual void __fastcall ApplyVariables(TLMDGetVariableEvent aGetVariableEvent);
	virtual TLMDBaseText* __fastcall Clone(void);
	virtual void __fastcall Store(Lmdwriter::TLMDWriter* AWriter);
	__property System::UnicodeString Text = {read=GetText};
	__property System::UnicodeString FontFace = {read=FFontFace, write=FFontFace};
	__property System::UnicodeString FontSize = {read=FFontSize, write=FFontSize};
	__property System::UnicodeString BaseFontSize = {read=FBaseFontSize, write=FBaseFontSize};
	__property System::Uitypes::TColor FontColor = {read=FFontColor, write=FFontColor, nodefault};
	__property System::Uitypes::TFontStyles FontStyle = {read=FFontStyle, write=FFontStyle, nodefault};
	__property System::Uitypes::TColor ShadowColor = {read=FShadowColor, write=FShadowColor, nodefault};
	__property System::Byte ShadowDepth = {read=FShadowDepth, write=FShadowDepth, nodefault};
	__property System::Uitypes::TColor LightColor = {read=FLightColor, write=FLightColor, nodefault};
	__property System::Byte LightDepth = {read=FLightDepth, write=FLightDepth, nodefault};
	__property TLMDTextStyle TextStyle = {read=FTextStyle, write=FTextStyle, nodefault};
	__property TLMDTextSubscriptStyle SubscriptStyle = {read=FSubscriptStyle, write=FSubscriptStyle, default=0};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDText(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetVariable(System::TObject* aObj, const System::UnicodeString aValue, TLMDGetVariableEvent aGetVariableEvent);
extern DELPHI_PACKAGE bool __fastcall IsVariable(const System::UnicodeString aValue);
}	/* namespace Lmdtext */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXT)
using namespace Lmdtext;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextHPP
