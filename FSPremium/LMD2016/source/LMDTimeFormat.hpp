// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTimeFormat.pas' rev: 31.00 (Windows)

#ifndef LmdtimeformatHPP
#define LmdtimeformatHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtimeformat
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTimeFormat;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDTimeFormats : unsigned char { tfShortSystem, tfLongSystem, tfCustom };

class PASCALIMPLEMENTATION TLMDTimeFormat : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	System::UnicodeString FFormatStr;
	TLMDTimeFormats FFormat;
	System::Classes::TNotifyEvent FOnFormatChanged;
	System::Classes::TNotifyEvent FOnFormatChange;
	Lmdtypes::TLMDString FAMSign;
	Lmdtypes::TLMDString FPMSign;
	Lmdtypes::TLMDString FMSign;
	bool F12hour;
	int FOffset;
	void __fastcall SetFormatStr(System::UnicodeString aValue);
	void __fastcall SetFormat(TLMDTimeFormats aValue);
	
public:
	System::UnicodeString __fastcall RemoveAMPM(System::UnicodeString &aTimeStr);
	__fastcall virtual TLMDTimeFormat(System::Classes::TPersistent* Owner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall DoFormatChanged(void);
	void __fastcall DoFormatChange(void);
	System::UnicodeString __fastcall GetFormatStr(void);
	System::UnicodeString __fastcall TimeToStr(System::TDateTime time);
	void __fastcall StrToHMS(System::UnicodeString str, System::Byte &h, System::Byte &m, System::Byte &s);
	void __fastcall StrToHMS24(System::UnicodeString str, System::Byte &h, System::Byte &m, System::Byte &s);
	System::TDateTime __fastcall StrToTime(System::UnicodeString str);
	System::UnicodeString __fastcall GetEditString(System::Byte h, System::Byte m, System::Byte s)/* overload */;
	System::UnicodeString __fastcall GetEditString(System::TDateTime dt)/* overload */;
	int __fastcall NextEditPos(int current, System::UnicodeString text);
	int __fastcall PrevEditPos(int current, System::UnicodeString text);
	int __fastcall CurrentLength(int current, System::UnicodeString text);
	int __fastcall CurrentStart(int current, System::UnicodeString text);
	int __fastcall CurrentType(int current, System::UnicodeString text);
	int __fastcall GetPattern(int current, System::UnicodeString text);
	void __fastcall GetPatInfo(int pattern, System::UnicodeString text, int &pat_start, int &pat_end, int &pat_type);
	__property System::Classes::TNotifyEvent OnFormatChanged = {read=FOnFormatChanged, write=FOnFormatChanged};
	__property System::Classes::TNotifyEvent OnFormatChange = {read=FOnFormatChange, write=FOnFormatChange};
	__property bool Is12HourFormat = {read=F12hour, nodefault};
	__property int Offset = {read=FOffset, write=FOffset, nodefault};
	
__published:
	__property System::UnicodeString FormatStr = {read=FFormatStr, write=SetFormatStr};
	__property TLMDTimeFormats Format = {read=FFormat, write=SetFormat, default=0};
	__property Lmdtypes::TLMDString AMSign = {read=FAMSign, write=FAMSign};
	__property Lmdtypes::TLMDString PMSign = {read=FPMSign, write=FPMSign};
	__property Lmdtypes::TLMDString MSign = {read=FMSign, write=FMSign};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDTimeFormat(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString cAMPMPlaceHolder;
}	/* namespace Lmdtimeformat */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTIMEFORMAT)
using namespace Lmdtimeformat;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtimeformatHPP
