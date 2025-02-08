// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSendKeys.pas' rev: 31.00 (Windows)

#ifndef LmdsendkeysHPP
#define LmdsendkeysHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsendkeys
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSendKeys;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSendKeyMode : unsigned char { kmhold, kmDown, kmUp };

class PASCALIMPLEMENTATION TLMDSendKeys : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	NativeUInt FHandle;
	NativeUInt FProcess;
	System::UnicodeString FLast;
	System::UnicodeString FCaption;
	System::UnicodeString FFilename;
	bool FActivateBeforeKey;
	bool FAutoActivate;
	bool FException;
	
public:
	__fastcall virtual TLMDSendKeys(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDSendKeys(void);
	void __fastcall SendKeys(System::UnicodeString s, bool wait = false);
	void __fastcall SendFile(System::UnicodeString filename, bool wait = false);
	bool __fastcall AppActivate(System::UnicodeString s = System::UnicodeString());
	bool __fastcall Shell(System::UnicodeString s);
	bool __fastcall ShellTerminate(void);
	__property System::UnicodeString Caption = {read=FCaption};
	__property NativeUInt Process = {read=FProcess, nodefault};
	__property System::UnicodeString FileName = {read=FFilename};
	__property NativeUInt WndHandle = {read=FHandle, write=FHandle, nodefault};
	
__published:
	__property About = {default=0};
	__property bool AutoActivate = {read=FAutoActivate, write=FAutoActivate, default=0};
	__property bool ActivateBeforeKey = {read=FActivateBeforeKey, write=FActivateBeforeKey, default=0};
	__property bool RaiseException = {read=FException, write=FException, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsendkeys */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSENDKEYS)
using namespace Lmdsendkeys;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsendkeysHPP
