// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeAxisScrollEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeaxisscrolleditHPP
#define Vcltee_TeeaxisscrolleditHPP

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
#include <VCLTee.TeeAxisToolEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeaxisscrolledit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAxisScrollEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAxisScrollEditor : public Vcltee::Teeaxistooledit::TAxisToolEditor
{
	typedef Vcltee::Teeaxistooledit::TAxisToolEditor inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* CBInverted;
	Vcl::Stdctrls::TLabel* Label2;
	Vcltee::Tecanvas::TComboFlat* CBLimit;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBInvertedClick(System::TObject* Sender);
	void __fastcall CBLimitChange(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAxisScrollEditor(System::Classes::TComponent* AOwner) : Vcltee::Teeaxistooledit::TAxisToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAxisScrollEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeaxistooledit::TAxisToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAxisScrollEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAxisScrollEditor(HWND ParentWindow) : Vcltee::Teeaxistooledit::TAxisToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeaxisscrolledit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEAXISSCROLLEDIT)
using namespace Vcltee::Teeaxisscrolledit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeaxisscrolleditHPP
