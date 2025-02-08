// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'intfLMDBackGround.pas' rev: 31.00 (Windows)

#ifndef IntflmdbackgroundHPP
#define IntflmdbackgroundHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <intfLMDBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Intflmdbackground
{
//-- forward type declarations -----------------------------------------------
__interface ILMDBackground;
typedef System::DelphiInterface<ILMDBackground> _di_ILMDBackground;
//-- type declarations -------------------------------------------------------
__interface  INTERFACE_UUID("{0068598D-C5C6-488F-8E00-D813525C9163}") ILMDBackground  : public System::IInterface 
{
	virtual Vcl::Graphics::TBitmap* __fastcall BackBitmap(void) = 0 ;
	virtual bool __fastcall BackBitmapCheck(void) = 0 ;
	virtual bool __fastcall BackDrawArea(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &dest, const System::Types::TPoint &src, System::Word flags = (System::Word)(0x0)) = 0 ;
	virtual bool __fastcall isTransparentSet(void) = 0 ;
	virtual System::Types::TPoint __fastcall BackMapPoint(const System::Types::TPoint &aValue) = 0 ;
	virtual HPALETTE __fastcall BackBitmapPalette(void) = 0 ;
	virtual void __fastcall BackUpdate(void) = 0 ;
	virtual Vcl::Controls::TControl* __fastcall BackControl(int index) = 0 ;
	virtual int __fastcall BackControlCount(void) = 0 ;
};

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* __fastcall LMDBackBitmap(Vcl::Controls::TControl* aControl);
extern DELPHI_PACKAGE bool __fastcall LMDBackBitmapCheck(Vcl::Controls::TControl* aControl);
extern DELPHI_PACKAGE bool __fastcall LMDBackDrawArea(Vcl::Controls::TControl* aControl, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &dest, const System::Types::TPoint &src, System::Word flags);
extern DELPHI_PACKAGE System::Types::TPoint __fastcall LMDBackMapPoint(Vcl::Controls::TControl* aControl, const System::Types::TPoint &aValue);
extern DELPHI_PACKAGE HPALETTE __fastcall LMDBackBitmapPalette(Vcl::Controls::TControl* aControl);
extern DELPHI_PACKAGE void __fastcall LMDBackUpdate(System::Classes::TComponent* notComponent, Vcl::Controls::TControl* aControl)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDBackUpdate(Vcl::Controls::TControl* aControl)/* overload */;
}	/* namespace Intflmdbackground */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_INTFLMDBACKGROUND)
using namespace Intflmdbackground;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// IntflmdbackgroundHPP
