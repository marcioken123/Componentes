// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomMaskEdit.pas' rev: 31.00 (Windows)

#ifndef LmdcustommaskeditHPP
#define LmdcustommaskeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDTypes.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDClass.hpp>
#include <LMDProcs.hpp>
#include <LMDCurrencySettings.hpp>
#include <LMDDateFormat.hpp>
#include <LMDTimeFormat.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustommaskedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDWrongDataType;
class DELPHICLASS TLMDParsedMaskRecord;
class DELPHICLASS TLMDCustomMaskEdit;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDMaskType : unsigned char { meInteger, meWord, meFloat, meFloatFixed, meFloatNumber, meCurrency, meDate, meTime, meMask, meNone, meDateTime };

enum DECLSPEC_DENUM TLMDNumberType : unsigned char { ntInteger, ntFloat, ntFloatFixed, ntFloatNumber, ntCurrency };

typedef System::Int8 TLMDNumberBase;

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDWrongDataType : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDWrongDataType(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDWrongDataType(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDWrongDataType(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDWrongDataType(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDWrongDataType(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDWrongDataType(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDWrongDataType(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDWrongDataType(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDWrongDataType(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDWrongDataType(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDWrongDataType(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDWrongDataType(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDWrongDataType(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDParsedMaskRecord : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Set<char, _DELPHI_SET_CHAR(0), _DELPHI_SET_CHAR(255)> chars;
	bool inputallowed;
	bool rangecheck;
	int top;
	int bottom;
	TLMDParsedMaskRecord* next;
	TLMDParsedMaskRecord* prev;
public:
	/* TObject.Create */ inline __fastcall TLMDParsedMaskRecord(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDParsedMaskRecord(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDOnUserRule)(System::TObject* Sender, bool &Ok, System::WideChar c, int at);

typedef void __fastcall (__closure *TLMDOnRangeError)(System::TObject* Sender, double Lower, double Upper, System::Extended &Value);

class PASCALIMPLEMENTATION TLMDCustomMaskEdit : public Lmdcustomedit::TLMDCustomEdit
{
	typedef Lmdcustomedit::TLMDCustomEdit inherited;
	
private:
	Lmdclass::TLMDEditModes FEditMode;
	Lmdtypes::TLMDString FSuffix;
	Lmdtypes::TLMDString FMask;
	TLMDNumberBase FNumberBase;
	TLMDOnUserRule FOnUserRule;
	bool FForceMaskCheck;
	bool FRangeCheck;
	System::WideChar FThousandDelim;
	System::WideChar FDecimalDelim;
	System::WideChar FBlankChar;
	bool FProcessBlankChar;
	bool FSuppressBlankCharOnDelete;
	int FDecimals;
	System::TDateTime FSavedDateTime;
	Lmddateformat::TLMDDateFormat* FDateSet;
	Lmdtimeformat::TLMDTimeFormat* FTimeSet;
	Lmdcurrencysettings::TLMDCurrencySettings* FCurSet;
	int FTDelims;
	int dep_help;
	int dep;
	double FMinValue;
	double FMaxValue;
	TLMDOnRangeError FOnRangeError;
	System::Classes::TNotifyEvent FOnError;
	bool FMinus;
	System::Word FCommandKey;
	void __fastcall SetMask(Lmdtypes::TLMDString aValue);
	void __fastcall SetMaskType(TLMDMaskType aValue);
	void __fastcall SetNumberBase(TLMDNumberBase aValue);
	void __fastcall SetBlankChar(System::WideChar aValue);
	void __fastcall SetProcessBlankChar(bool aValue);
	HIDESBASE void __fastcall SetInteger(int index, int aValue);
	void __fastcall SetDouble(int index, double aValue);
	void __fastcall SetCurSet(Lmdcurrencysettings::TLMDCurrencySettings* aValue);
	void __fastcall SetDateFormat(Lmddateformat::TLMDDateFormat* aValue);
	void __fastcall SetTimeFormat(Lmdtimeformat::TLMDTimeFormat* aValue);
	void __fastcall SetSuffix(Lmdtypes::TLMDString aValue);
	void __fastcall SetForceMaskCheck(const bool Value);
	void __fastcall SetForceOverwriteMode(const bool Value);
	HIDESBASE MESSAGE void __fastcall WMChar(Winapi::Messages::TWMKey &Msg);
	void __fastcall WriteData(System::Classes::TWriter* Writer);
	void __fastcall ReadData(System::Classes::TReader* Reader);
	Lmdtypes::TLMDString __fastcall literalChars(void);
	int __fastcall inputCharsAllowedAt(int at);
	bool __fastcall RealCharAllowedAt(int at, System::WideChar c);
	bool __fastcall CharAllowedAt(int at, System::WideChar c);
	int __fastcall NeededEntered(Lmdtypes::TLMDString s);
	System::WideChar __fastcall getCharAt(int at);
	bool __fastcall checkText(Lmdtypes::TLMDString s);
	HIDESBASE MESSAGE void __fastcall WMKILLFOCUS(Winapi::Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMSETFOCUS(Winapi::Messages::TWMSetFocus &Message);
	int __fastcall GetAsInteger(void);
	unsigned __fastcall GetAsCardinal(void);
	__int64 __fastcall GetAsInt64(void);
	double __fastcall GetAsFloat(void);
	System::TDateTime __fastcall GetAsDate(void);
	System::TDateTime __fastcall GetAsTime(void);
	System::TDateTime __fastcall GetAsDateTime(void);
	double __fastcall GetAsCurrency(void);
	Lmdtypes::TLMDString __fastcall GetAsString(void);
	void __fastcall SetAsCardinal(const unsigned Value);
	void __fastcall SetAsCurrency(const double Value);
	void __fastcall SetAsFloat(const double Value);
	void __fastcall SetAsInt64(const __int64 Value);
	void __fastcall SetAsInteger(const int Value);
	void __fastcall SetAsString(const Lmdtypes::TLMDString Value);
	void __fastcall SetAsTime(const System::TDateTime Value);
	void __fastcall SetAsDate(const System::TDateTime Value);
	void __fastcall SetAsDateTime(const System::TDateTime Value);
	Lmdtypes::TLMDString __fastcall GetUnMaskedText(void);
	void __fastcall SetUnMaskedText(Lmdtypes::TLMDString aValue);
	void __fastcall SetSuppressBlankCharOnDelete(const bool aValue);
	
protected:
	Lmdtypes::TLMDString FOldText;
	TLMDMaskType FMaskType;
	virtual Lmdtypes::TLMDString __fastcall GetEmptyText(void);
	virtual Lmdtypes::TLMDString __fastcall GetValueToValidate(void);
	bool __fastcall isLiteral(int charPos);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall HandleInsertText(int at, Lmdtypes::TLMDString &aValue);
	virtual void __fastcall HandleReplaceText(int at, Lmdtypes::TLMDString aValue);
	virtual void __fastcall BeforeChangeText(void);
	virtual void __fastcall FinishedSetSelText(void);
	virtual void __fastcall ChangedText(int At);
	virtual void __fastcall CreateSpecialText(Lmdtypes::TLMDString &s);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DoValidationError(void);
	virtual void __fastcall CursorPosChanged(void);
	DYNAMIC void __fastcall GetCommandKey(System::Word &KeyCode, System::Classes::TShiftState Shift);
	virtual void __fastcall DateTimeInc(int aStep);
	virtual void __fastcall DateTimeDec(int aStep);
	DYNAMIC bool __fastcall DoMouseWheel(System::Classes::TShiftState Shift, int WheelDelta, const System::Types::TPoint &MousePos);
	void __fastcall ToDate(int step);
	void __fastcall ToTime(int step);
	virtual bool __fastcall AllowedOperation(Lmdtypes::TLMDString textToInsert);
	virtual void __fastcall GetChange(System::TObject* Sender);
	bool __fastcall IsTextStored(void);
	virtual int __fastcall CalcMousePos(System::Types::TSmallPoint Pos);
	void __fastcall DateFormatChange(System::TObject* Sender);
	void __fastcall DateFormatChanged(System::TObject* Sender);
	Lmdtypes::TLMDString __fastcall DateTimeString(System::TDateTime aDatetime);
	void __fastcall CheckNumberRange(void);
	Lmdtypes::TLMDString __fastcall GetSuffix(void);
	__property int Decimals = {read=FDecimals, write=SetInteger, index=0, default=1};
	__property Lmdtypes::TLMDString Suffix = {read=FSuffix, write=SetSuffix};
	__property double MinValue = {read=FMinValue, write=SetDouble, index=1};
	__property double MaxValue = {read=FMaxValue, write=SetDouble, index=2};
	__property bool RangeCheck = {read=FRangeCheck, write=FRangeCheck, nodefault};
	__property TLMDOnRangeError OnRangeError = {read=FOnRangeError, write=FOnRangeError};
	__property bool ForceMaskCheck = {read=FForceMaskCheck, write=SetForceMaskCheck, default=0};
	__property bool ForceOverwriteMode = {read=FForceOverwriteMode, write=SetForceOverwriteMode, default=0};
	
public:
	__property int AsInteger = {read=GetAsInteger, write=SetAsInteger, nodefault};
	__property unsigned AsCardinal = {read=GetAsCardinal, write=SetAsCardinal, nodefault};
	__property __int64 AsInt64 = {read=GetAsInt64, write=SetAsInt64};
	__property double AsFloat = {read=GetAsFloat, write=SetAsFloat};
	__property System::TDateTime AsDate = {read=GetAsDate, write=SetAsDate};
	__property System::TDateTime AsTime = {read=GetAsTime, write=SetAsTime};
	__property System::TDateTime AsDateTime = {read=GetAsDateTime, write=SetAsDateTime};
	__property double AsCurrency = {read=GetAsCurrency, write=SetAsCurrency};
	__property Lmdtypes::TLMDString AsString = {read=GetAsString, write=SetAsString};
	__fastcall virtual TLMDCustomMaskEdit(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomMaskEdit(void);
	int __fastcall NextEditChar(void);
	int __fastcall PrevEditChar(void);
	Lmdtypes::TLMDString __fastcall FormatTextByMask(const Lmdtypes::TLMDString AUnMaskedText);
	void __fastcall ForceMaskValidation(void);
	virtual void __fastcall CutToClipboard(void);
	virtual void __fastcall PasteFromClipboard(void);
	Lmdtypes::TLMDString __fastcall GetPureText(void);
	void __fastcall SetTextWithSuffix(Lmdtypes::TLMDString aValue);
	void __fastcall SetValue(double aValue);
	__property Lmdcurrencysettings::TLMDCurrencySettings* CurrencySettings = {read=FCurSet, write=SetCurSet};
	__property Lmddateformat::TLMDDateFormat* DateSettings = {read=FDateSet, write=SetDateFormat};
	__property Lmdtimeformat::TLMDTimeFormat* TimeSettings = {read=FTimeSet, write=SetTimeFormat};
	__property Lmdtypes::TLMDString Mask = {read=FMask, write=SetMask};
	__property TLMDMaskType MaskType = {read=FMaskType, write=SetMaskType, default=8};
	__property TLMDNumberBase NumberBase = {read=FNumberBase, write=SetNumberBase, default=10};
	__property System::WideChar BlankChar = {read=FBlankChar, write=SetBlankChar, default=95};
	__property bool ProcessBlankChar = {read=FProcessBlankChar, write=SetProcessBlankChar, default=0};
	__property bool SuppressBlankCharOnDelete = {read=FSuppressBlankCharOnDelete, write=SetSuppressBlankCharOnDelete, default=0};
	__property Text = {stored=IsTextStored};
	__property Lmdtypes::TLMDString UnMaskedText = {read=GetUnMaskedText, write=SetUnMaskedText};
	__property TLMDOnUserRule OnUserRule = {read=FOnUserRule, write=FOnUserRule};
	
__published:
	__property System::Classes::TNotifyEvent OnValidationError = {read=FOnError, write=FOnError};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomMaskEdit(HWND ParentWindow) : Lmdcustomedit::TLMDCustomEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Extended __fastcall LMDIntPower(System::Extended X, int I);
extern DELPHI_PACKAGE __int64 __fastcall LMDGetDecimalValue(int base, Lmdtypes::TLMDString s);
extern DELPHI_PACKAGE double __fastcall LMDGetDecimalFloatValue(int base, Lmdtypes::TLMDString source);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDGetBaseString(int base, int value);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDFloatToStrF(System::Extended Value, System::Sysutils::TFloatFormat Format, int Base, int Precision, int Digits);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDClearTS(Lmdtypes::TLMDString s);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall convertVCLMask2LMDMask(Lmdtypes::TLMDString aMask);
}	/* namespace Lmdcustommaskedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMMASKEDIT)
using namespace Lmdcustommaskedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustommaskeditHPP
