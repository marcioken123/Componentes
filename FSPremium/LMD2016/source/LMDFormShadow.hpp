// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFormShadow.pas' rev: 31.00 (Windows)

#ifndef LmdformshadowHPP
#define LmdformshadowHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDShadow.hpp>
#include <LMDGraph.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdformshadow
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFormShadow;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFormShadow : public Lmdwndproccomponent::TLMDWndProcComponent
{
	typedef Lmdwndproccomponent::TLMDWndProcComponent inherited;
	
private:
	bool bMouseCapture;
	HWND hRightWindow;
	HWND hBottomWindow;
	Lmdgraph::TLMDShadowStyle tmpShadowStyle;
	Lmdshadow::TLMDShadow* FShadow;
	bool FIAShadow;
	void __fastcall CreateShadow(void);
	void __fastcall DestroyShadow(void);
	void __fastcall HideShadow(void);
	bool __fastcall IsNoShadow(void);
	void __fastcall MoveShadow(void);
	void __fastcall SetShadow(Lmdshadow::TLMDShadow* aValue);
	void __fastcall SetShadowParams(HWND hWindow);
	void __fastcall ShowShadowWnd(int iCmdShow);
	void __fastcall ShowShadow(void);
	
protected:
	virtual void __fastcall Init(void);
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall RestoreState(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDFormShadow(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFormShadow(void);
	
__published:
	__property About = {default=0};
	__property Lmdshadow::TLMDShadow* Shadow = {read=FShadow, write=SetShadow};
	__property Enabled = {default=1};
	__property bool ShowInActive = {read=FIAShadow, write=FIAShadow, default=1};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdformshadow */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFORMSHADOW)
using namespace Lmdformshadow;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdformshadowHPP
