// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWebHTMLScan.pas' rev: 31.00 (Windows)

#ifndef LmdwebhtmlscanHPP
#define LmdwebhtmlscanHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Contnrs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDWebBase.hpp>
#include <LMDWebHTMLLex.hpp>
#include <LMDWebLex.hpp>
#include <LMDCustomComponent.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwebhtmlscan
{
//-- forward type declarations -----------------------------------------------
struct TLMDWebImageTag;
struct TLMDWebAppletTag;
struct TLMDWebFormTag;
struct TLMDWebFrameTag;
struct TLMDWebFrameSetTag;
struct TLMDWebIFrameTag;
struct TLMDWebObjectTag;
struct TLMDWebTableTag;
struct TLMDWebTrTag;
struct TLMDWebTdTag;
class DELPHICLASS TLMDWebHTMLScan;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDOnTagEvent)(System::UnicodeString szTagName, System::Classes::TStringList* Attributes, int iStartPosition, int iEndPosition);

typedef void __fastcall (__closure *TLMDOnTextEvent)(System::UnicodeString szText, int iStartPosition, int iEndPosition);

typedef void __fastcall (__closure *TLMDOnEndTagEvent)(System::UnicodeString szTagName, int iStartPosition, int iEndPosition);

enum DECLSPEC_DENUM TLMDWebHTMLAlign : unsigned char { haAbsBottom, haAbsMiddle, haBaseLine, haTextTop, haLeft, haRight, haTop, haMiddle, haBottom };

enum DECLSPEC_DENUM TLMDWebHTMLResize : unsigned char { hrNoResize, hrResize };

enum DECLSPEC_DENUM TLMDWebHTMLScrolling : unsigned char { hsAuto, hsYes, hsNo };

enum DECLSPEC_DENUM TLMDWebHTMLFrameBorder : unsigned char { fbYes, fbNo, fb0, fb1 };

enum DECLSPEC_DENUM TLMDWebHTMLScriptLanguage : unsigned char { slJavaScript, slJScript, slVBScript };

enum DECLSPEC_DENUM TLMDWebHTMLTableFrame : unsigned char { tfAbove, tfBelow, tfBox, tfInsides, tfLHS, tfRHS, tfVoid, tfVSides };

enum DECLSPEC_DENUM TLMDWebHTMLTableRules : unsigned char { trAll, trCols, trGroups, trNone, trRows };

enum DECLSPEC_DENUM TLMDWebHTMLVAlign : unsigned char { vaBaseLine, vaBottom, vaCenter, vaTop };

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDWebImageTag
{
public:
	System::UnicodeString SRC;
	System::UnicodeString ALT;
	TLMDWebHTMLAlign align;
	int width;
	int height;
	int border;
	int hspace;
	int vspace;
	System::UnicodeString usemap;
	bool ismap;
};
#pragma pack(pop)


typedef void __fastcall (__closure *TLMDOnImageTagEvent)(const TLMDWebImageTag &Params, System::Classes::TStringList* Attributes, int iStartPosition, int iEndPosition);

typedef void __fastcall (__closure *TLMDOnTitleTagEvent)(System::UnicodeString szTitle, int iStartPosition, int iEndPosition);

typedef void __fastcall (__closure *TLMDOnLinkTagEvent)(System::UnicodeString szURL, System::UnicodeString szTarget, System::UnicodeString szText, int iStartPosition, int iEndPosition);

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDWebAppletTag
{
public:
	TLMDWebHTMLAlign align;
	System::UnicodeString code;
	System::UnicodeString codebase;
	System::UnicodeString dataFld;
	System::UnicodeString dataSrc;
	int hspace;
	int vspace;
	System::UnicodeString id;
	bool isTextEdit;
	System::UnicodeString name;
	System::UnicodeString src;
	System::UnicodeString title;
};
#pragma pack(pop)


typedef void __fastcall (__closure *TLMDOnAppletTagEvent)(System::UnicodeString szText, const TLMDWebAppletTag &Params, System::Classes::TStringList* Attributes, int iStartPosition, int iEndPosition);

typedef void __fastcall (__closure *TLMDOnBodyTagEvent)(System::UnicodeString szBody, int iStartPosition, int iEndPosition);

typedef void __fastcall (__closure *TLMDOnDivTagEvent)(System::Classes::TStringList* Attributes, int iStartPosition);

typedef void __fastcall (__closure *TLMDOnFontTagEvent)(System::Classes::TStringList* Attributes, int iStartPosition);

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDWebFormTag
{
public:
	System::UnicodeString action;
	System::UnicodeString id;
	System::UnicodeString method;
	System::UnicodeString name;
	System::UnicodeString target;
	System::UnicodeString title;
};
#pragma pack(pop)


typedef void __fastcall (__closure *TLMDOnFormTagEvent)(System::UnicodeString szForm, const TLMDWebFormTag &Params, System::Classes::TStringList* Attributes, int iStartPosition, int iEndPosition);

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDWebFrameTag
{
public:
	System::UnicodeString borderColor;
	System::UnicodeString frameBorder;
	int height;
	System::UnicodeString id;
	int marginHeight;
	int marginWidth;
	System::UnicodeString name;
	TLMDWebHTMLResize noResize;
	TLMDWebHTMLScrolling scrolling;
	System::UnicodeString src;
};
#pragma pack(pop)


typedef void __fastcall (__closure *TLMDOnFrameTagEvent)(const TLMDWebFrameTag &Params, System::Classes::TStringList* Attributes, int iStartPosition, int iEndPosition);

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDWebFrameSetTag
{
public:
	int border;
	System::UnicodeString borderColor;
	int cols;
	TLMDWebHTMLFrameBorder frameBorder;
	int frameSpacing;
	System::UnicodeString id;
	int rows;
};
#pragma pack(pop)


typedef void __fastcall (__closure *TLMDOnFrameSetTagEvent)(System::UnicodeString szFrameSet, const TLMDWebFrameSetTag &Params, System::Classes::TStringList* Attributes, int iStartPosition, int iEndPosition);

typedef void __fastcall (__closure *TLMDOnHeadTagEvent)(System::UnicodeString szHead, int iStartPosition, int iEndPosition);

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDWebIFrameTag
{
public:
	TLMDWebHTMLAlign align;
	int border;
	System::UnicodeString borderColor;
	TLMDWebHTMLFrameBorder frameBorder;
	int frameSpacing;
	int height;
	int hspace;
	System::UnicodeString id;
	TLMDWebHTMLResize noResize;
	TLMDWebHTMLScrolling scrolling;
	System::UnicodeString src;
	int vspace;
	int width;
};
#pragma pack(pop)


typedef void __fastcall (__closure *TLMDOnIFrameTagEvent)(const TLMDWebIFrameTag &Params, System::Classes::TStringList* Attributes, int iStartPosition);

typedef void __fastcall (__closure *TLMDOnUlTagEvent)(System::UnicodeString List, System::Classes::TStringList* Attributes, int iStartPosition, int iEndPosition);

typedef void __fastcall (__closure *TLMDOnOlTagEvent)(System::UnicodeString List, System::Classes::TStringList* Attributes, int iStartPosition, int iEndPosition);

typedef void __fastcall (__closure *TLMDOnLiTagEvent)(System::UnicodeString szText, System::Classes::TStringList* Attributes, int iStartPosition, int iEndPosition);

typedef void __fastcall (__closure *TLMDOnMapTagEvent)(System::UnicodeString szMap, System::Classes::TStringList* Attribute, int iStartPosition, int iEndPosition);

typedef void __fastcall (__closure *TLMDOnMetaTagEvent)(System::Classes::TStringList* Attribute, int iStartPosition, int iEndPosition);

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDWebObjectTag
{
public:
	TLMDWebHTMLAlign align;
	System::UnicodeString code;
	System::UnicodeString codebase;
	System::UnicodeString dataFld;
	System::UnicodeString data;
	System::UnicodeString dataSrc;
	bool disabled;
	int height;
	System::UnicodeString id;
	bool isTextEdit;
	System::UnicodeString name;
	System::UnicodeString title;
	System::UnicodeString type_;
	int width;
};
#pragma pack(pop)


typedef void __fastcall (__closure *TLMDOnObjectTagEvent)(System::UnicodeString szText, const TLMDWebObjectTag &Params, System::Classes::TStringList* Attributes, int iStartPosition, int iEndPosition);

typedef void __fastcall (__closure *TLMDOnScriptTagEvent)(System::UnicodeString szScript, TLMDWebHTMLScriptLanguage Language, System::Classes::TStringList* Attributes, int iStartPosition, int iEndPosition);

typedef void __fastcall (__closure *TLMDOnStyleTagEvent)(System::UnicodeString szStyle, System::Classes::TStringList* Attributes, int iStartPosition, int iEndPosition);

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDWebTableTag
{
public:
	TLMDWebHTMLAlign align;
	System::UnicodeString background;
	System::UnicodeString bgColor;
	int border;
	System::UnicodeString borderColor;
	System::UnicodeString borderColorDark;
	System::UnicodeString borderColorLight;
	int cellPadding;
	int cellSpacing;
	int cols;
	TLMDWebHTMLTableFrame frame;
	int height;
	System::UnicodeString id;
	TLMDWebHTMLTableRules rules;
	int scrollHeight;
	int scrollLeft;
	int scrollTop;
	int scrollWidth;
	System::UnicodeString style;
	System::UnicodeString title;
	int width;
};
#pragma pack(pop)


typedef void __fastcall (__closure *TLMDOnTableTagEvent)(const TLMDWebTableTag &Params, System::Classes::TStringList* Attributes, int iStartPosition);

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDWebTrTag
{
public:
	TLMDWebHTMLAlign align;
	System::UnicodeString bgColor;
	System::UnicodeString borderColor;
	System::UnicodeString borderColorDark;
	System::UnicodeString borderColorLight;
	System::UnicodeString style;
	System::UnicodeString title;
	TLMDWebHTMLVAlign valign;
};
#pragma pack(pop)


typedef void __fastcall (__closure *TLMDOnTrTagEvent)(const TLMDWebTrTag &Params, System::Classes::TStringList* Attributes, int iStartPosition);

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDWebTdTag
{
public:
	TLMDWebHTMLAlign align;
	System::UnicodeString background;
	System::UnicodeString bgColor;
	System::UnicodeString borderColor;
	System::UnicodeString borderColorDark;
	System::UnicodeString borderColorLight;
	int colSpan;
	int height;
	System::UnicodeString id;
	bool noWrap;
	int rowSpan;
	System::UnicodeString style;
	System::UnicodeString title;
	TLMDWebHTMLVAlign valign;
	int width;
};
#pragma pack(pop)


typedef void __fastcall (__closure *TLMDOnTdTagEvent)(System::UnicodeString szTd, const TLMDWebTdTag &Params, System::Classes::TStringList* Attributes, int iStartPosition, int iEndPosition);

class PASCALIMPLEMENTATION TLMDWebHTMLScan : public Lmdwebbase::TLMDWebComponent
{
	typedef Lmdwebbase::TLMDWebComponent inherited;
	
private:
	System::Classes::TStringList* FHTML;
	TLMDOnTagEvent FOnTagEvent;
	TLMDOnTextEvent FOnTextEvent;
	bool FReplaceSpecialChars;
	TLMDOnTagEvent FOnStartTagEvent;
	TLMDOnEndTagEvent FOnEndTagEvent;
	TLMDOnImageTagEvent FOnImageTagEvent;
	TLMDOnTitleTagEvent FOnTitleTagEvent;
	TLMDOnLinkTagEvent FOnLinkTagEvent;
	TLMDOnAppletTagEvent FOnAppletTagEvent;
	TLMDOnBodyTagEvent FOnBodyTagEvent;
	TLMDOnDivTagEvent FOnDivTagEvent;
	TLMDOnFontTagEvent FOnFontTagEvent;
	TLMDOnFormTagEvent FOnFormTagEvent;
	TLMDOnFrameTagEvent FOnFrameTagEvent;
	TLMDOnFrameSetTagEvent FOnFrameSetTagEvent;
	TLMDOnHeadTagEvent FOnHeadTagEvent;
	TLMDOnIFrameTagEvent FOnIFrameTagEvent;
	TLMDOnUlTagEvent FOnUlTagEvent;
	TLMDOnOlTagEvent FOnOlTagEvent;
	TLMDOnLiTagEvent FOnLiTagEvent;
	TLMDOnMapTagEvent FOnMapTagEvent;
	TLMDOnMetaTagEvent FOnMetaTagEvent;
	TLMDOnObjectTagEvent FOnObjectTagEvent;
	TLMDOnScriptTagEvent FOnScriptTagEvent;
	TLMDOnStyleTagEvent FOnStyleTagEvent;
	TLMDOnTableTagEvent FOnTableTagEvent;
	TLMDOnTrTagEvent FOnTrTagEvent;
	TLMDOnTdTagEvent FOnTdTagEvent;
	System::Uitypes::TEditCharCase FTagCharCase;
	System::Classes::TNotifyEvent FOnAfterParse;
	System::Classes::TNotifyEvent FOnBeforeParse;
	void __fastcall SetHTML(System::Classes::TStringList* const Value);
	void __fastcall SetOnTagEvent(const TLMDOnTagEvent Value);
	int __fastcall GetTG(void);
	Lmdweblex::TLMDWebToken* __fastcall GetToken(int Index);
	void __fastcall SetOnTextEvent(const TLMDOnTextEvent Value);
	void __fastcall SetReplaceSpecialChars(const bool Value);
	void __fastcall SetOnStartTagEvent(const TLMDOnTagEvent Value);
	void __fastcall SetOnEndTagEvent(const TLMDOnEndTagEvent Value);
	void __fastcall SetOnImageTagEvent(const TLMDOnImageTagEvent Value);
	void __fastcall SetOnTitleTagEvent(const TLMDOnTitleTagEvent Value);
	void __fastcall SetOnLinkTagEvent(const TLMDOnLinkTagEvent Value);
	void __fastcall SetOnAppletTagEvent(const TLMDOnAppletTagEvent Value);
	void __fastcall SetOnBodyTagEvent(const TLMDOnBodyTagEvent Value);
	void __fastcall SetOnDivTagEvent(const TLMDOnDivTagEvent Value);
	void __fastcall SetOnFontTagEvent(const TLMDOnFontTagEvent Value);
	void __fastcall SetOnFormTagEvent(const TLMDOnFormTagEvent Value);
	void __fastcall SetOnFrameTagEvent(const TLMDOnFrameTagEvent Value);
	void __fastcall SetOnFrameSetTagEvent(const TLMDOnFrameSetTagEvent Value);
	void __fastcall SetOnHeadTagEvent(const TLMDOnHeadTagEvent Value);
	void __fastcall SetOnIFrameTagEvent(const TLMDOnIFrameTagEvent Value);
	void __fastcall SetOnUlTagEvent(const TLMDOnUlTagEvent Value);
	void __fastcall SetOnOlTagEvent(const TLMDOnOlTagEvent Value);
	void __fastcall SetOnLiTagEvent(const TLMDOnLiTagEvent Value);
	void __fastcall SetOnMapTagEvent(const TLMDOnMapTagEvent Value);
	void __fastcall SetOnMetaTagEvent(const TLMDOnMetaTagEvent Value);
	void __fastcall SetOnObjectTagEvent(const TLMDOnObjectTagEvent Value);
	void __fastcall SetOnScriptTagEvent(const TLMDOnScriptTagEvent Value);
	void __fastcall SetOnStyleTagEvent(const TLMDOnStyleTagEvent Value);
	void __fastcall SetOnTableTagEvent(const TLMDOnTableTagEvent Value);
	void __fastcall SetOnTrTagEvent(const TLMDOnTrTagEvent Value);
	void __fastcall SetOnTdTagEvent(const TLMDOnTdTagEvent Value);
	void __fastcall SetTagCharCase(const System::Uitypes::TEditCharCase Value);
	void __fastcall SetOnAfterParse(const System::Classes::TNotifyEvent Value);
	void __fastcall SetOnBeforeParse(const System::Classes::TNotifyEvent Value);
	
protected:
	Lmdwebhtmllex::TLMDWebHTMLLex* FLex;
	System::Contnrs::TObjectList* FTags;
	
public:
	__fastcall virtual TLMDWebHTMLScan(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDWebHTMLScan(void);
	bool __fastcall Parse(void);
	__property int TokensCount = {read=GetTG, default=0};
	__property Lmdweblex::TLMDWebToken* Token[int Index] = {read=GetToken};
	
__published:
	__property bool ReplaceSpecialChars = {read=FReplaceSpecialChars, write=SetReplaceSpecialChars, default=1};
	__property System::Classes::TStringList* HTML = {read=FHTML, write=SetHTML};
	__property System::Uitypes::TEditCharCase TagCharCase = {read=FTagCharCase, write=SetTagCharCase, nodefault};
	__property System::Classes::TNotifyEvent OnBeforeParse = {read=FOnBeforeParse, write=SetOnBeforeParse};
	__property System::Classes::TNotifyEvent OnAfterParse = {read=FOnAfterParse, write=SetOnAfterParse};
	__property TLMDOnTagEvent OnTagEvent = {read=FOnTagEvent, write=SetOnTagEvent};
	__property TLMDOnTextEvent OnTextEvent = {read=FOnTextEvent, write=SetOnTextEvent};
	__property TLMDOnTagEvent OnStartTagEvent = {read=FOnStartTagEvent, write=SetOnStartTagEvent};
	__property TLMDOnEndTagEvent OnEndTagEvent = {read=FOnEndTagEvent, write=SetOnEndTagEvent};
	__property TLMDOnImageTagEvent OnImageTagEvent = {read=FOnImageTagEvent, write=SetOnImageTagEvent};
	__property TLMDOnTitleTagEvent OnTitleTagEvent = {read=FOnTitleTagEvent, write=SetOnTitleTagEvent};
	__property TLMDOnLinkTagEvent OnLinkTagEvent = {read=FOnLinkTagEvent, write=SetOnLinkTagEvent};
	__property TLMDOnAppletTagEvent OnAppletTagEvent = {read=FOnAppletTagEvent, write=SetOnAppletTagEvent};
	__property TLMDOnBodyTagEvent OnBodyTagEvent = {read=FOnBodyTagEvent, write=SetOnBodyTagEvent};
	__property TLMDOnDivTagEvent OnDivTagEvent = {read=FOnDivTagEvent, write=SetOnDivTagEvent};
	__property TLMDOnFontTagEvent OnFontTagEvent = {read=FOnFontTagEvent, write=SetOnFontTagEvent};
	__property TLMDOnFormTagEvent OnFormTagEvent = {read=FOnFormTagEvent, write=SetOnFormTagEvent};
	__property TLMDOnFrameTagEvent OnFrameTagEvent = {read=FOnFrameTagEvent, write=SetOnFrameTagEvent};
	__property TLMDOnFrameSetTagEvent OnFrameSetTagEvent = {read=FOnFrameSetTagEvent, write=SetOnFrameSetTagEvent};
	__property TLMDOnHeadTagEvent OnHeadTagEvent = {read=FOnHeadTagEvent, write=SetOnHeadTagEvent};
	__property TLMDOnIFrameTagEvent OnIFrameTagEvent = {read=FOnIFrameTagEvent, write=SetOnIFrameTagEvent};
	__property TLMDOnUlTagEvent OnUlTagEvent = {read=FOnUlTagEvent, write=SetOnUlTagEvent};
	__property TLMDOnOlTagEvent OnOlTagEvent = {read=FOnOlTagEvent, write=SetOnOlTagEvent};
	__property TLMDOnLiTagEvent OnLiTagEvent = {read=FOnLiTagEvent, write=SetOnLiTagEvent};
	__property TLMDOnMapTagEvent OnMapTagEvent = {read=FOnMapTagEvent, write=SetOnMapTagEvent};
	__property TLMDOnMetaTagEvent OnMetaTagEvent = {read=FOnMetaTagEvent, write=SetOnMetaTagEvent};
	__property TLMDOnObjectTagEvent OnObjectTagEvent = {read=FOnObjectTagEvent, write=SetOnObjectTagEvent};
	__property TLMDOnScriptTagEvent OnScriptTagEvent = {read=FOnScriptTagEvent, write=SetOnScriptTagEvent};
	__property TLMDOnStyleTagEvent OnStyleTagEvent = {read=FOnStyleTagEvent, write=SetOnStyleTagEvent};
	__property TLMDOnTableTagEvent OnTableTagEvent = {read=FOnTableTagEvent, write=SetOnTableTagEvent};
	__property TLMDOnTrTagEvent OnTrTagEvent = {read=FOnTrTagEvent, write=SetOnTrTagEvent};
	__property TLMDOnTdTagEvent OnTdTagEvent = {read=FOnTdTagEvent, write=SetOnTdTagEvent};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdwebhtmlscan */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWEBHTMLSCAN)
using namespace Lmdwebhtmlscan;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwebhtmlscanHPP
