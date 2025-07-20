// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeAxisScrollBarEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeaxisscrollbareditHPP
#define Vcltee_TeeaxisscrollbareditHPP

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
#include <VCLTee.TeeAxisToolEdit.hpp>
#include <Vcl.StdCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeeLegendScrollBarEditor.hpp>
#include <VCLTee.TeEngine.hpp>
#include <Vcl.ComCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeaxisscrollbaredit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAxisScrollBarEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAxisScrollBarEditor : public Vcltee::Teeaxistooledit::TAxisToolEditor
{
	typedef Vcltee::Teeaxistooledit::TAxisToolEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabScrollOptions;
	Vcl::Comctrls::TTabSheet* TabScrollFormat;
	Vcl::Stdctrls::TCheckBox* CBAllowResize;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TEdit* EMargin;
	Vcl::Comctrls::TUpDown* UDMargin;
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBAllowResizeClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall EMarginChange(System::TObject* Sender);
	
private:
	Vcltee::Teelegendscrollbareditor::TScrollbarEditor* IEditor;
	
protected:
	virtual Vcltee::Teengine::TChartAxis* __fastcall GetAxis();
	virtual void __fastcall SetAxis(Vcltee::Teengine::TChartAxis* const AAxis);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAxisScrollBarEditor(System::Classes::TComponent* AOwner) : Vcltee::Teeaxistooledit::TAxisToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAxisScrollBarEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeaxistooledit::TAxisToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAxisScrollBarEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAxisScrollBarEditor(HWND ParentWindow) : Vcltee::Teeaxistooledit::TAxisToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeaxisscrollbaredit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEAXISSCROLLBAREDIT)
using namespace Vcltee::Teeaxisscrollbaredit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeaxisscrollbareditHPP
