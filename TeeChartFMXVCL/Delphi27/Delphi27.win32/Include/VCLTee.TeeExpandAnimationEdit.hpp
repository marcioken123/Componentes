// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeExpandAnimationEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeexpandanimationeditHPP
#define Vcltee_TeeexpandanimationeditHPP

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
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeAnimations.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeCustomShapeEditor.hpp>
#include <VCLTee.TeePenDlg.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeexpandanimationedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TExpandAnimationEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TExpandAnimationEdit : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcltee::Tecanvas::TComboFlat* CBTarget;
	Vcltee::Tecanvas::TComboFlat* CBTrigger;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* ESizeBy;
	Vcl::Comctrls::TUpDown* UDSizeBy;
	void __fastcall ESizeByChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBTriggerChange(System::TObject* Sender);
	void __fastcall CBTargetChange(System::TObject* Sender);
	
private:
	Vcltee::Teeanimations::TCustomExpandAnimation* Animation;
	void __fastcall RefreshControls(Vcltee::Teeanimations::TCustomExpandAnimation* AAnimation);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TExpandAnimationEdit(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TExpandAnimationEdit(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TExpandAnimationEdit() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TExpandAnimationEdit(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeexpandanimationedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEEXPANDANIMATIONEDIT)
using namespace Vcltee::Teeexpandanimationedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeexpandanimationeditHPP
