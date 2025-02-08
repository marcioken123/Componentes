// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFMDrop.pas' rev: 31.00 (Windows)

#ifndef LmdfmdropHPP
#define LmdfmdropHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <LMDSysIn.hpp>
#include <LMDClass.hpp>
#include <LMDHookComponent.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfmdrop
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFMDrop;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDFMDragDropEvent)(System::TObject* Sender, int fcount, int x, int y, System::Classes::TStrings* FileList);

class PASCALIMPLEMENTATION TLMDFMDrop : public Lmdhookcomponent::TLMDCustomHookComponent
{
	typedef Lmdhookcomponent::TLMDCustomHookComponent inherited;
	
private:
	TLMDFMDragDropEvent FOnDragDrop;
	Lmdclass::TLMDCharCase FCharCase;
	
protected:
	void __fastcall HandleMessage(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall Init(void);
	DYNAMIC void __fastcall RestoreState(void);
	virtual void __fastcall TriggerBeforeProcessEvent(Winapi::Messages::TMessage &Msg, bool &Handled);
	virtual void __fastcall TriggerAfterProcessEvent(Winapi::Messages::TMessage &Msg, bool &Handled);
	
public:
	__fastcall virtual TLMDFMDrop(System::Classes::TComponent* AOwner);
	
__published:
	__property About = {default=0};
	__property Lmdclass::TLMDCharCase CharCase = {read=FCharCase, write=FCharCase, default=0};
	__property Control;
	__property Enabled = {default=1};
	__property TLMDFMDragDropEvent OnFMDragDrop = {read=FOnDragDrop, write=FOnDragDrop};
public:
	/* TLMDCustomHookComponent.Destroy */ inline __fastcall virtual ~TLMDFMDrop(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfmdrop */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFMDROP)
using namespace Lmdfmdrop;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfmdropHPP
