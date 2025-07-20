// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeChartBlock3DEditor.pas' rev: 34.00 (Windows)

#ifndef Teechartblock3deditorHPP
#define Teechartblock3deditorHPP

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
#include <Vcl.ComCtrls.hpp>
#include <TeeBlockEditor.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeGLEditor.hpp>
#include <VCLTee.TeeEdi3D.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teechartblock3deditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TChartBlock3DEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TChartBlock3DEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabObject;
	Vcl::Comctrls::TTabSheet* TabOpenGL;
	Vcl::Comctrls::TTabSheet* Tab3D;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Vcltee::Teeedi3d::TFormTee3D* I3DEdit;
	Teeblockeditor::TBlockEditor* IEdit;
	Vcltee::Teegleditor::TFormTeeGLEditor* IGLEdit;
	Vcltee::Teeprocs::TCustomTeePanel* IPanel;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TChartBlock3DEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TChartBlock3DEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TChartBlock3DEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TChartBlock3DEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teechartblock3deditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEECHARTBLOCK3DEDITOR)
using namespace Teechartblock3deditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Teechartblock3deditorHPP
