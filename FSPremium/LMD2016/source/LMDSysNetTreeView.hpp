// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysNetTreeView.pas' rev: 31.00 (Windows)

#ifndef LmdsysnettreeviewHPP
#define LmdsysnettreeviewHPP

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
#include <Vcl.ComCtrls.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysTreeView.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysnettreeview
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysNetTreeView;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysNetTreeView : public Lmdsystreeview::TLMDSysTreeView
{
	typedef Lmdsystreeview::TLMDSysTreeView inherited;
	
private:
	Vcl::Controls::TImageList* FImageList;
	void __fastcall LoadImageList(void);
	
public:
	__fastcall virtual TLMDSysNetTreeView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDSysNetTreeView(void);
	__property Items;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSysNetTreeView(HWND ParentWindow) : Lmdsystreeview::TLMDSysTreeView(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysnettreeview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSNETTREEVIEW)
using namespace Lmdsysnettreeview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysnettreeviewHPP
