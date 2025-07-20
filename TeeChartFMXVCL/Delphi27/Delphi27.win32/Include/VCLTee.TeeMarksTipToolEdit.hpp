// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeMarksTipToolEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeemarkstiptooleditHPP
#define Vcltee_TeemarkstiptooleditHPP

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
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeToolSeriesEdit.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeEdiSeri.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teemarkstiptooledit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMarksTipToolEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TMarksTipToolEdit : public Vcltee::Teetoolseriesedit::TSeriesToolEditor
{
	typedef Vcltee::Teetoolseriesedit::TSeriesToolEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabFormat;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcltee::Tecanvas::TComboFlat* CBMarkStyle;
	Vcl::Extctrls::TRadioGroup* RGMouseAction;
	Vcl::Stdctrls::TEdit* EDelay;
	Vcl::Comctrls::TUpDown* UDDelay;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDHideDelay;
	Vcl::Stdctrls::TCheckBox* CBSystem;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBMarkStyleChange(System::TObject* Sender);
	void __fastcall RGMouseActionClick(System::TObject* Sender);
	void __fastcall EDelayChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall CBSystemClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	Vcltee::Teetools::TMarksTipTool* MarksTool;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TMarksTipToolEdit(System::Classes::TComponent* AOwner) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMarksTipToolEdit(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TMarksTipToolEdit() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TMarksTipToolEdit(HWND ParentWindow) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teemarkstiptooledit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEMARKSTIPTOOLEDIT)
using namespace Vcltee::Teemarkstiptooledit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeemarkstiptooleditHPP
