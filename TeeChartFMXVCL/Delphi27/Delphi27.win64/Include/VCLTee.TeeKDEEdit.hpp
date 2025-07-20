// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeKDEEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeekdeeditHPP
#define Vcltee_TeekdeeditHPP

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
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.StatChar.hpp>
#include <VCLTee.TeeBoxPlot.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teekdeedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TKDEEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TKDEEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabViolin;
	Vcl::Comctrls::TTabSheet* TabKDE;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* LRes;
	Vcl::Stdctrls::TEdit* IntRes;
	Vcl::Stdctrls::TCheckBox* CheckBox1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* IntBandW;
	Vcl::Stdctrls::TLabel* lblClamp;
	Vcl::Stdctrls::TComboBox* cbClamp;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* EdiClampMin;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* EdiClampMax;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TEdit* IntPos;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall IntResChange(System::TObject* Sender);
	void __fastcall IntBandWChange(System::TObject* Sender);
	void __fastcall IntWidthChange(System::TObject* Sender);
	void __fastcall cbClampChange(System::TObject* Sender);
	void __fastcall EdiClampMinChange(System::TObject* Sender);
	void __fastcall EdiClampMaxChange(System::TObject* Sender);
	void __fastcall IntPosChange(System::TObject* Sender);
	
private:
	Vcltee::Teeboxplot::TViolinSeries* Violin;
	void __fastcall EnableClampMinMax();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TKDEEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TKDEEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TKDEEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TKDEEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TKDEEditor* KDEEditor;
extern DELPHI_PACKAGE bool FIsBeeswarm;
}	/* namespace Teekdeedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEKDEEDIT)
using namespace Vcltee::Teekdeedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeekdeeditHPP
