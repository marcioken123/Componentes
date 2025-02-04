// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sFrameAdapter.pas' rev: 27.00 (Windows)

#ifndef SframeadapterHPP
#define SframeadapterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <acSBUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sframeadapter
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsFrameAdapter;
class PASCALIMPLEMENTATION TsFrameAdapter : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
protected:
	Scommondata::TsScrollWndData* FCommonData;
	bool __fastcall PrepareCache(void);
	void __fastcall OurPaintHandler(HDC aDC);
	void __fastcall AC_WMPaint(const HDC aDC);
	
public:
	Vcl::Forms::TFrame* Frame;
	System::Classes::TWndMethod OldWndProc;
	Acsbutils::TacScrollWnd* ListSW;
	virtual void __fastcall Loaded(void);
	virtual void __fastcall AfterConstruction(void);
	__fastcall virtual TsFrameAdapter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsFrameAdapter(void);
	void __fastcall NewWndProc(Winapi::Messages::TMessage &Message);
	
__published:
	__property Scommondata::TsScrollWndData* SkinData = {read=FCommonData, write=FCommonData};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Sframeadapter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SFRAMEADAPTER)
using namespace Sframeadapter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SframeadapterHPP
