// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeAxisArrowEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeaxisarroweditHPP
#define Vcltee_TeeaxisarroweditHPP

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
#include <VCLTee.TeeAxisToolEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeTools.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeaxisarrowedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAxisArrowToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAxisArrowToolEditor : public Vcltee::Teeaxistooledit::TAxisToolEditor
{
	typedef Vcltee::Teeaxistooledit::TAxisToolEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabPattern;
	Vcl::Stdctrls::TLabel* LL;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Comctrls::TUpDown* UDLength;
	Vcl::Stdctrls::TEdit* ELength;
	Vcltee::Tecanvas::TComboFlat* CBPos;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDScroll;
	Vcl::Stdctrls::TCheckBox* CBInv;
	Vcl::Comctrls::TUpDown* UDSize;
	Vcl::Stdctrls::TEdit* ESize;
	Vcl::Stdctrls::TEdit* EWidth;
	Vcl::Comctrls::TUpDown* UDWidth;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ELC(System::TObject* Sender);
	void __fastcall CBPosChange(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall CBInvClick(System::TObject* Sender);
	void __fastcall ESizeChange(System::TObject* Sender);
	void __fastcall EWidthChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	
private:
	Vcltee::Teetools::TAxisArrowTool* AxisArrowTool;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAxisArrowToolEditor(System::Classes::TComponent* AOwner) : Vcltee::Teeaxistooledit::TAxisToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAxisArrowToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeaxistooledit::TAxisToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAxisArrowToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAxisArrowToolEditor(HWND ParentWindow) : Vcltee::Teeaxistooledit::TAxisToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeaxisarrowedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEAXISARROWEDIT)
using namespace Vcltee::Teeaxisarrowedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeaxisarroweditHPP
