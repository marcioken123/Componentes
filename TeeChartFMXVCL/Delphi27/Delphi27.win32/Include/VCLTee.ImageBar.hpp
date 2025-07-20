// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.ImageBar.pas' rev: 34.00 (Windows)

#ifndef Vcltee_ImagebarHPP
#define Vcltee_ImagebarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Imagebar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TImageBarSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TImageBarSeries : public Vcltee::Series::TBarSeries
{
	typedef Vcltee::Series::TBarSeries inherited;
	
private:
	Vcltee::Tecanvas::TTeePicture* FImage;
	bool FImageTiled;
	bool FImageTransp;
	void __fastcall DrawTiled(const System::Types::TRect &R, bool StartFromTop);
	HIDESBASE void __fastcall SetImage(Vcltee::Tecanvas::TTeePicture* const Value);
	void __fastcall SetImageTiled(const bool Value);
	void __fastcall SetImageTransp(const bool Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual TImageBarSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TImageBarSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall DrawBar(int BarIndex, int StartPos, int EndPos);
	
__published:
	__property Vcltee::Tecanvas::TTeePicture* Image = {read=FImage, write=SetImage};
	__property bool ImageTiled = {read=FImageTiled, write=SetImageTiled, default=0};
	__property bool ImageTransparent = {read=FImageTransp, write=SetImageTransp, default=0};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LoadBitmapFromResourceName(Vcl::Graphics::TBitmap* const ABitmap, const System::UnicodeString ResName);
}	/* namespace Imagebar */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_IMAGEBAR)
using namespace Vcltee::Imagebar;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_ImagebarHPP
