// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.About.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_AboutHPP
#define Fmxtee_AboutHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Forms3D.hpp>
#include <FMX.Controls3D.hpp>
#include <FMX.MaterialSources.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Types3D.hpp>
#include <FMX.Objects3D.hpp>
#include <FMX.Ani.hpp>
#include <FMXTee.Chart3D.hpp>
#include <FMX.Materials.hpp>
#include <FMX.Layers3D.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace About
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFormAbout;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TFormAbout : public Fmx::Forms3d::TForm3D
{
	typedef Fmx::Forms3d::TForm3D inherited;
	
__published:
	Fmx::Objects3d::TText3D* LVersion;
	Fmxtee::Chart3d::TChart3D* Chart3D1;
	Fmx::Ani::TFloatAnimation* FloatAnimation2;
	Fmxtee::Series::TBarSeries* Series1;
	Fmx::Layers3d::TImage3D* Image3D1;
	Fmx::Objects3d::TText3D* TextOffer;
	Fmx::Ani::TFloatAnimation* FloatAnimation4;
	void __fastcall Form3DCreate(System::TObject* Sender);
	void __fastcall Text3D3Click(System::TObject* Sender);
	void __fastcall Form3DActivate(System::TObject* Sender);
	void __fastcall Form3DKeyUp(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	
public:
	__classmethod void __fastcall About(System::Classes::TComponent* const AOwner);
public:
	/* TCustomForm3D.Create */ inline __fastcall virtual TFormAbout(System::Classes::TComponent* AOwner) : Fmx::Forms3d::TForm3D(AOwner) { }
	/* TCustomForm3D.CreateNew */ inline __fastcall virtual TFormAbout(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms3d::TForm3D(AOwner, Dummy) { }
	/* TCustomForm3D.Destroy */ inline __fastcall virtual ~TFormAbout() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool TeeIsTrial;
}	/* namespace About */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_ABOUT)
using namespace Fmxtee::About;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_AboutHPP
