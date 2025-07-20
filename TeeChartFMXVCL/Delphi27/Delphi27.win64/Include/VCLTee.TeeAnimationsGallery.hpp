// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeAnimationsGallery.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeanimationsgalleryHPP
#define Vcltee_TeeanimationsgalleryHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeToolsGallery.hpp>
#include <VCLTee.TeeAnimations.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeanimationsgallery
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeAnimationsGallery;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTeeAnimationsGallery : public Vcltee::Teetoolsgallery::TTeeToolsGallery
{
	typedef Vcltee::Teetoolsgallery::TTeeToolsGallery inherited;
	
__published:
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	
protected:
	virtual void __fastcall FillTools();
	virtual bool __fastcall FilterTool(int Index);
	
public:
	Vcltee::Teeanimations::TTeeAnimationTool* __fastcall AddNewAnimation(Vcltee::Teengine::TChartAnimations* const Animations);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTeeAnimationsGallery(System::Classes::TComponent* AOwner) : Vcltee::Teetoolsgallery::TTeeToolsGallery(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTeeAnimationsGallery(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teetoolsgallery::TTeeToolsGallery(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTeeAnimationsGallery() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTeeAnimationsGallery(HWND ParentWindow) : Vcltee::Teetoolsgallery::TTeeToolsGallery(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Vcltee::Teetoolsgallery::TToolsGalleryHook AnimationsGalleryHook;
}	/* namespace Teeanimationsgallery */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEANIMATIONSGALLERY)
using namespace Vcltee::Teeanimationsgallery;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeanimationsgalleryHPP
