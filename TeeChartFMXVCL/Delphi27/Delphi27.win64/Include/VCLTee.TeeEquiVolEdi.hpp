// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeEquiVolEdi.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeequivolediHPP
#define Vcltee_TeeequivolediHPP

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
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeEdiGrad.hpp>
#include <VCLTee.TeeEquiVolume.hpp>
#include <VCLTee.TeePoEdi.hpp>
#include <VCLTee.TeeProCo.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeequivoledi
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TEquiVolumeEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TEquiVolumeEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcltee::Tecanvas::TButtonColor* BUpColor;
	Vcltee::Tecanvas::TButtonColor* BDownColor;
	Vcl::Stdctrls::TLabel* Label2;
	Vcltee::Tecanvas::TComboFlat* CBColorStyle;
	Vcl::Stdctrls::TLabel* LDepth;
	Vcl::Stdctrls::TEdit* EPGap;
	Vcl::Comctrls::TUpDown* UDPGap;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBColorStyleChange(System::TObject* Sender);
	void __fastcall EPGapChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Vcl::Forms::TCustomForm* PointerForm;
	Vcltee::Teeequivolume::TEquiVolumeSeries* EquiVolume;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TEquiVolumeEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TEquiVolumeEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TEquiVolumeEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TEquiVolumeEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeequivoledi */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEEQUIVOLEDI)
using namespace Vcltee::Teeequivoledi;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeequivolediHPP
