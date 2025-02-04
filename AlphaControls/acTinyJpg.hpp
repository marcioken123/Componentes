// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acTinyJPG.pas' rev: 27.00 (Windows)

#ifndef ActinyjpgHPP
#define ActinyjpgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.AxCtrls.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Actinyjpg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TacTinyJPGImage;
class PASCALIMPLEMENTATION TacTinyJPGImage : public Vcl::Axctrls::TOleGraphic
{
	typedef Vcl::Axctrls::TOleGraphic inherited;
	
public:
	virtual void __fastcall LoadFromFile(const System::UnicodeString Filename);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
public:
	/* TOleGraphic.Create */ inline __fastcall virtual TacTinyJPGImage(void) : Vcl::Axctrls::TOleGraphic() { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacTinyJPGImage(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Actinyjpg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACTINYJPG)
using namespace Actinyjpg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ActinyjpgHPP
