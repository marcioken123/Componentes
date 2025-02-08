// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElSysHotKey.pas' rev: 31.00 (Windows)

#ifndef ElsyshotkeyHPP
#define ElsyshotkeyHPP

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
#include <Winapi.Messages.hpp>
#include <Vcl.Menus.hpp>
#include <LMDDebugUnit.hpp>
#include <System.Types.hpp>
#include <ElBaseComp.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elsyshotkey
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElSysHotKey;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElSysHotKey : public Elbasecomp::TElBaseComponent
{
	typedef Elbasecomp::TElBaseComponent inherited;
	
protected:
	System::Word fID;
	System::Classes::TNotifyEvent FOnPress;
	System::Classes::TShortCut FShortcut;
	virtual void __fastcall TriggerPress(void);
	virtual void __fastcall DoSetEnabled(bool AEnabled);
	MESSAGE void __fastcall WMHotKey(Winapi::Messages::TWMHotKey &Message);
	void __fastcall SetShortcut(System::Classes::TShortCut Value);
	
public:
	__fastcall virtual ~TElSysHotKey(void);
	__fastcall virtual TElSysHotKey(System::Classes::TComponent* AOwner);
	
__published:
	__property Enabled = {default=0};
	__property System::Classes::TNotifyEvent OnPress = {read=FOnPress, write=FOnPress};
	__property System::Classes::TShortCut Shortcut = {read=FShortcut, write=SetShortcut, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elsyshotkey */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELSYSHOTKEY)
using namespace Elsyshotkey;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElsyshotkeyHPP
