// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDScrollBoxExt.pas' rev: 31.00 (Windows)

#ifndef LmdscrollboxextHPP
#define LmdscrollboxextHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomScrollBoxExt.hpp>
#include <LMDCustomControl.hpp>
#include <LMDBackPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMDSBar.hpp>
#include <LMDFaceController.hpp>
#include <LMDBevel.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdscrollboxext
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDScrollBoxExt;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDScrollBoxExt : public Lmdcustomscrollboxext::TLMDCustomScrollBoxExt
{
	typedef Lmdcustomscrollboxext::TLMDCustomScrollBoxExt inherited;
	
__published:
	__property VertScrollBar;
	__property HorzScrollBar;
	__property FaceController;
	__property Bevel;
	__property InstantUpdate = {default=1};
	__property Transparent = {default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnPaint;
public:
	/* TLMDCustomScrollBoxExt.Create */ inline __fastcall virtual TLMDScrollBoxExt(System::Classes::TComponent* AOwner) : Lmdcustomscrollboxext::TLMDCustomScrollBoxExt(AOwner) { }
	/* TLMDCustomScrollBoxExt.Destroy */ inline __fastcall virtual ~TLMDScrollBoxExt(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDScrollBoxExt(HWND ParentWindow) : Lmdcustomscrollboxext::TLMDCustomScrollBoxExt(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdscrollboxext */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCROLLBOXEXT)
using namespace Lmdscrollboxext;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdscrollboxextHPP
