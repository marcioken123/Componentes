// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeDraw3DEditor.pas' rev: 34.00 (Windows)

#ifndef Teedraw3deditorHPP
#define Teedraw3deditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teedraw3deditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDraw3DEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDraw3DEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* Tab3D;
	Vcl::Comctrls::TTabSheet* TabPanel;
	Vcl::Comctrls::TTabSheet* TabExport;
	Vcl::Comctrls::TTabSheet* TabPrint;
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	Vcltee::Teeprocs::TCustomTeePanelExtended* Panel;
	void __fastcall BroadcastOnShow(Vcl::Comctrls::TTabSheet* ATab);
	
public:
	__classmethod void __fastcall Edit(System::Classes::TComponent* AOwner, Vcltee::Teeprocs::TCustomTeePanelExtended* APanel);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDraw3DEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDraw3DEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDraw3DEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDraw3DEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teedraw3deditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEDRAW3DEDITOR)
using namespace Teedraw3deditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Teedraw3deditorHPP
