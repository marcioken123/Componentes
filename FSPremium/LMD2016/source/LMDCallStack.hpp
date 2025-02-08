// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCallStack.pas' rev: 31.00 (Windows)

#ifndef LmdcallstackHPP
#define LmdcallstackHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcallstack
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStackFrame;
class DELPHICLASS TLMDCallStack;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStackFrame : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	unsigned FMapAddress;
	System::UnicodeString __fastcall GetFileName(void);
	int __fastcall GetLineNumber(void);
	System::UnicodeString __fastcall GetMethodName(void);
	
public:
	__fastcall TLMDStackFrame(unsigned AAddress);
	virtual System::UnicodeString __fastcall ToString(void);
	bool __fastcall IsEmpty(void);
	__property System::UnicodeString FileName = {read=GetFileName};
	__property int LineNumber = {read=GetLineNumber, nodefault};
	__property System::UnicodeString Method = {read=GetMethodName};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDStackFrame(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCallStack : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<TLMDStackFrame*> _TLMDCallStack__1;
	
	
private:
	_TLMDCallStack__1 FCallStack;
	int FMaxStackLevel;
	bool FSkipEmptyFrames;
	bool __fastcall CheckCallAddress(unsigned AAddress);
	TLMDStackFrame* __fastcall GetStackFrame(int Index);
	int __fastcall GetFrameCount(void);
	void __fastcall SetMaxStackLevel(const int Value);
	
public:
	__fastcall TLMDCallStack(void);
	__fastcall virtual ~TLMDCallStack(void);
	__classmethod TLMDCallStack* __fastcall Instance();
	virtual System::UnicodeString __fastcall ToString(void);
	int __fastcall FillCallStack(int ACallStackLength);
	__property bool SkipEmptyFrames = {read=FSkipEmptyFrames, write=FSkipEmptyFrames, nodefault};
	__property int MaxStackLevel = {read=FMaxStackLevel, write=SetMaxStackLevel, nodefault};
	__property int FrameCount = {read=GetFrameCount, nodefault};
	__property TLMDStackFrame* StackFrames[int Index] = {read=GetStackFrame};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE int __fastcall GetCallStack(TLMDStackFrame* *ACallStack, const int ACallStack_High);
}	/* namespace Lmdcallstack */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCALLSTACK)
using namespace Lmdcallstack;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcallstackHPP
