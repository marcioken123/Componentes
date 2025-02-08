// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomBevelPanel.pas' rev: 31.00 (Windows)

#ifndef LmdcustombevelpanelHPP
#define LmdcustombevelpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDBevel.hpp>
#include <LMDGraph.hpp>
#include <LMDClass.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustombevelpanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomBevelPanel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomBevelPanel : public Lmdcustompanel::TLMDCustomPanel
{
	typedef Lmdcustompanel::TLMDCustomPanel inherited;
	
private:
	void __fastcall SetBevel(Lmdbevel::TLMDBevel* aValue);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMLMDBevelChanged(Winapi::Messages::TMessage &Message);
	
protected:
	Lmdbevel::TLMDBevel* FBevel;
	bool FNoHandleUpdate;
	virtual System::Types::TRect __fastcall GetSizeRect(void);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall MouseEnter(void);
	virtual void __fastcall MouseExit(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall RestoreBorderBack(void);
	DYNAMIC void __fastcall RestoreBorderFront(void);
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	virtual void __fastcall AdjustClientRect(System::Types::TRect &Rect);
	int __fastcall BevelExt(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	int __fastcall DblBevelExt(void);
	System::Types::TRect __fastcall BeveledRect(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	virtual void __fastcall Paint(void);
	virtual Lmdbevel::TLMDBevel* __fastcall GetBevel(void);
	virtual void __fastcall CreateBevel(void);
	
public:
	__fastcall virtual TLMDCustomBevelPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomBevelPanel(void);
	__property Lmdbevel::TLMDBevel* Bevel = {read=FBevel, write=SetBevel};
	__property Transparent = {default=0};
	
__published:
	__property bool NoHandleUpdate = {read=FNoHandleUpdate, write=FNoHandleUpdate, default=0};
	__property OnGesture;
	__property Touch;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomBevelPanel(HWND ParentWindow) : Lmdcustompanel::TLMDCustomPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustombevelpanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMBEVELPANEL)
using namespace Lmdcustombevelpanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustombevelpanelHPP
