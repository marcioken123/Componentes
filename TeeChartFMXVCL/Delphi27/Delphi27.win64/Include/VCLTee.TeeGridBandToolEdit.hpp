// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeGridBandToolEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeegridbandtooleditHPP
#define Vcltee_TeegridbandtooleditHPP

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
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeeGDIPlus.hpp>
#include <VCLTee.TeeAxisToolEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeDraw3D.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeEdiGrad.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teegridbandtooledit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGridBandToolEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TGridBandToolEdit : public Vcltee::Teeaxistooledit::TAxisToolEditor
{
	typedef Vcltee::Teeaxistooledit::TAxisToolEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabBand1;
	Vcl::Comctrls::TTabSheet* TabBand2;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Comctrls::TTrackBar* TBTransp1;
	Vcl::Stdctrls::TLabel* LTransp1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* LTransp2;
	Vcl::Comctrls::TTrackBar* TBTransp2;
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall TBTransp1Change(System::TObject* Sender);
	void __fastcall TBTransp2Change(System::TObject* Sender);
	
private:
	Vcltee::Teetools::TGridBandTool* GridBand;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TGridBandToolEdit(System::Classes::TComponent* AOwner) : Vcltee::Teeaxistooledit::TAxisToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TGridBandToolEdit(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeaxistooledit::TAxisToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TGridBandToolEdit() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridBandToolEdit(HWND ParentWindow) : Vcltee::Teeaxistooledit::TAxisToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teegridbandtooledit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEGRIDBANDTOOLEDIT)
using namespace Vcltee::Teegridbandtooledit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeegridbandtooleditHPP
