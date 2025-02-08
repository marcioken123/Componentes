// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElRegExpr.pas' rev: 31.00 (Windows)

#ifndef ElregexprHPP
#define ElregexprHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDTypes.hpp>
#include <LMDRegExpr.hpp>
#include <LMDFiles.hpp>
#include <LMDProcs.hpp>
#include <LMDStrings.hpp>
#include <ElComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elregexpr
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElRegOptions;
struct TElRegExpHeader;
class DELPHICLASS TElRegExpr;
//-- type declarations -------------------------------------------------------
typedef void * PPCRECalloutBlock;

typedef void __fastcall (__closure *TElCalloutEvent)(System::TObject* Sender, const void * Data);

class PASCALIMPLEMENTATION TElRegOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FFlags;
	System::Classes::TNotifyEvent FOnChange;
	bool __fastcall GetCaseLess(void);
	bool __fastcall GetExtended(void);
	bool __fastcall GetMultiLine(void);
	bool __fastcall GetSingleLine(void);
	bool __fastcall GetUngreedy(void);
	bool __fastcall GetUTF8(void);
	void __fastcall SetCaseLess(const bool Value);
	void __fastcall SetExtended(const bool Value);
	void __fastcall SetMultiLine(const bool Value);
	void __fastcall SetSingleLine(const bool Value);
	void __fastcall SetUngreedy(const bool Value);
	void __fastcall SetUTF8(const bool Value);
	void __fastcall TriggerChange(void);
	
protected:
	__property int Flags = {read=FFlags, nodefault};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TElRegOptions(void);
	
__published:
	__property bool eroCaseLess = {read=GetCaseLess, write=SetCaseLess, default=1};
	__property bool eroSingleLine = {read=GetSingleLine, write=SetSingleLine, default=1};
	__property bool eroMultiLine = {read=GetMultiLine, write=SetMultiLine, default=0};
	__property bool eroExtendedMode = {read=GetExtended, write=SetExtended, default=1};
	__property bool eroUngreedyMode = {read=GetUngreedy, write=SetUngreedy, default=0};
	__property bool eroUTF8 = {read=GetUTF8, write=SetUTF8, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElRegOptions(void) { }
	
};


struct DECLSPEC_DRECORD TElRegExpHeader
{
public:
	int Id;
	int Flags;
};


class PASCALIMPLEMENTATION TElRegExpr : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
protected:
	Lmdregexpr::TLMDRegExp* FRegExprEngine;
	TElRegOptions* FOptions;
	System::UnicodeString FInputText;
	int FMatchCountLimit;
	TElCalloutEvent FOnCalloutEvent;
	void __fastcall Compile(void);
	System::UnicodeString __fastcall GetMatch(int i);
	int __fastcall GetMatchLen(int i);
	int __fastcall GetMatchPos(int i);
	int __fastcall GetNumMatches(void);
	System::UnicodeString __fastcall GetExpr(void);
	void __fastcall SetExpr(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetInputText(void);
	void __fastcall SetInputText(const System::UnicodeString Value);
	void __fastcall DoChange(System::TObject* Sender);
	
public:
	__fastcall virtual TElRegExpr(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElRegExpr(void);
	void __fastcall Study(void);
	void __fastcall SaveToStream(System::Classes::TStream* AStream);
	void __fastcall LoadFromStream(System::Classes::TStream* AStream);
	void __fastcall SaveToFile(Lmdtypes::TLMDString AFileName);
	void __fastcall LoadFromFile(Lmdtypes::TLMDString AFileName);
	bool __fastcall Exec(void)/* overload */;
	bool __fastcall Exec(const System::UnicodeString AInputText)/* overload */;
	bool __fastcall ExecNext(void);
	bool __fastcall ExecPos(int AStartOffs);
	void __fastcall Split(System::UnicodeString AInputText, System::Classes::TStrings* AResult)/* overload */;
	void __fastcall Split(System::Classes::TStrings* AResult)/* overload */;
	System::UnicodeString __fastcall Substitute(const System::UnicodeString ATemplate);
	System::UnicodeString __fastcall Replace(const System::UnicodeString AReplace, bool AUseTemplates)/* overload */;
	System::UnicodeString __fastcall Replace(const System::UnicodeString AInputText, const System::UnicodeString AReplace, bool AUseTemplates)/* overload */;
	__property System::UnicodeString Match[int i] = {read=GetMatch};
	__property int MatchPos[int i] = {read=GetMatchPos};
	__property int MatchLen[int i] = {read=GetMatchLen};
	__property int MatchCount = {read=GetNumMatches, nodefault};
	
__published:
	__property TElRegOptions* Options = {read=FOptions};
	__property int MatchCountLimit = {read=FMatchCountLimit, default=100};
	__property System::UnicodeString Expression = {read=GetExpr, write=SetExpr};
	__property System::UnicodeString InputText = {read=GetInputText, write=SetInputText};
	__property TElCalloutEvent OnCallout = {read=FOnCalloutEvent, write=FOnCalloutEvent};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elregexpr */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELREGEXPR)
using namespace Elregexpr;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElregexprHPP
