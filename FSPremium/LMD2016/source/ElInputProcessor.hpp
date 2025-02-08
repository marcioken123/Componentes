// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElInputProcessor.pas' rev: 31.00 (Windows)

#ifndef ElinputprocessorHPP
#define ElinputprocessorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDUnicodeStrings.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Imm.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDSysIn.hpp>
#include <LMDStrings.hpp>
#include <LMDUnicode.hpp>
#include <LMDObjectList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elinputprocessor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElDeadChar;
class DELPHICLASS TElDeadCharList;
class DELPHICLASS TElKeyboardInputProcessor;
class DELPHICLASS TElKeyboardInput;
class DELPHICLASS TSearchTextTimeoutThread;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElEditCharCase : unsigned char { eecNormal, eecUpperCase, eecLowerCase };

typedef int __stdcall (*TIMECompositionStringProc)(int hImc, unsigned dWord1, void * lpBuf, unsigned dwBufLen);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDeadChar : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::WideChar FAuxChar;
	System::WideChar FBaseChar;
	System::WideChar FDeadChar;
	
protected:
	void __fastcall SetAuxChar(const System::WideChar Value);
	void __fastcall SetBaseChar(const System::WideChar Value);
	void __fastcall SetDeadChar(const System::WideChar Value);
	
public:
	__fastcall TElDeadChar(const System::WideChar ABaseChar, const System::WideChar AAuxChar, const System::WideChar ADeadChar);
	__property System::WideChar AuxChar = {read=FAuxChar, nodefault};
	__property System::WideChar BaseChar = {read=FBaseChar, nodefault};
	__property System::WideChar DeadChar = {read=FDeadChar, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TElDeadChar(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElDeadCharList : public Lmdobjectlist::TLMDObjectList
{
	typedef Lmdobjectlist::TLMDObjectList inherited;
	
private:
	System::WideChar __fastcall GetDeadCharByIndex(int index);
	System::WideChar __fastcall GetAuxCharByIndex(int index);
	System::WideChar __fastcall GetBaseCharByIndex(int index);
	
public:
	__fastcall TElDeadCharList(void);
	void __fastcall AddDeadChar(TElDeadChar* AElDeadChar);
	System::WideChar __fastcall GetDeadChar(System::WideChar ABaseChar, System::WideChar AAuxChar);
	__property System::WideChar DeadChars[int index] = {read=GetDeadCharByIndex};
	__property System::WideChar BaseChars[int index] = {read=GetBaseCharByIndex};
	__property System::WideChar AuxChars[int index] = {read=GetAuxCharByIndex};
public:
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TElDeadCharList(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElKeyboardInputProcessor : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	TElEditCharCase FCharCase;
	int FCDead;
	System::WideChar FDeadChar;
	TElDeadCharList* FDeadCharList;
	NativeUInt FHandle;
	Lmdtypes::TLMDString FResultStr;
	virtual void __fastcall SetCharCase(TElEditCharCase Value);
	virtual void __fastcall SetResultStr(Lmdtypes::TLMDString Value);
	
public:
	__fastcall TElKeyboardInputProcessor(void);
	__fastcall virtual ~TElKeyboardInputProcessor(void);
	virtual void __fastcall WMDeadChar(const Winapi::Messages::TWMKey &Msg);
	virtual void __fastcall WMImeComposition(const Winapi::Messages::TMessage &Msg);
	virtual void __fastcall WMKeyDown(const Winapi::Messages::TWMKey &Msg);
	virtual void __fastcall WMChar(const Winapi::Messages::TWMKey &Msg);
	bool __fastcall HandleAllocated(void);
	__property TElEditCharCase CharCase = {read=FCharCase, write=SetCharCase, default=0};
	__property NativeUInt Handle = {read=FHandle, write=FHandle, nodefault};
	__property Lmdtypes::TLMDString ResultStr = {read=FResultStr, write=SetResultStr};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElKeyboardInput : public TElKeyboardInputProcessor
{
	typedef TElKeyboardInputProcessor inherited;
	
protected:
	Lmdtypes::TLMDString FText;
	virtual void __fastcall SetCharCase(TElEditCharCase Value);
	virtual void __fastcall SetResultStr(Lmdtypes::TLMDString Value);
	__property Lmdtypes::TLMDString ResultStr = {read=FResultStr, write=SetResultStr};
	
public:
	__fastcall TElKeyboardInput(void);
	__fastcall virtual ~TElKeyboardInput(void);
	bool __fastcall IsRepeatSymbolString(void);
	virtual void __fastcall WMKeyDown(const Winapi::Messages::TWMKey &Msg);
	void __fastcall Reset(void);
	__property Lmdtypes::TLMDString Text = {read=FText};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TSearchTextTimeoutThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	_RTL_CRITICAL_SECTION CriticalSection;
	bool fKeepAlive;
	int FIncrementalSearchTimeout;
	void __fastcall SetKeepAlive(bool KeepAlive);
	bool __fastcall GetKeepAlive(void);
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TSearchTextTimeoutThread(void);
	__fastcall virtual ~TSearchTextTimeoutThread(void);
	__property int IncrementalSearchTimeout = {read=FIncrementalSearchTimeout, write=FIncrementalSearchTimeout, nodefault};
	__property bool KeepAlive = {read=GetKeepAlive, write=SetKeepAlive, default=0};
};


typedef int __stdcall (*ToUnicodeProc)(unsigned wVirtKey, unsigned wScanCode, const Winapi::Windows::TKeyboardState &KeyState, void *pwszBuff, int cchBuff, unsigned wFlags);

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::WideString __fastcall KeyToUnicode(const System::AnsiString Key);
}	/* namespace Elinputprocessor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELINPUTPROCESSOR)
using namespace Elinputprocessor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElinputprocessorHPP
