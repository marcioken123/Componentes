// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeTernaryEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeternaryeditHPP
#define Vcltee_TeeternaryeditHPP

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
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeeTernary.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeTextShapeEditor.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeternaryedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTernarySeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTernarySeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabPointer;
	Vcl::Stdctrls::TLabel* lblTStyle;
	Vcl::Stdctrls::TLabel* LblTLStyle;
	Vcl::Stdctrls::TLabel* LblTransparency;
	Vcl::Stdctrls::TLabel* LblAxisIncr;
	Vcl::Stdctrls::TComboBox* ComboTStyle;
	Vcl::Stdctrls::TComboBox* ComboTLStyle;
	Vcl::Stdctrls::TCheckBox* CBoxPointer;
	Vcl::Stdctrls::TCheckBox* CBoxColorEach;
	Vcl::Stdctrls::TComboBox* CBAxisIncr;
	Vcl::Stdctrls::TCheckBox* CBAuto;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Comctrls::TTrackBar* TBTransp;
	Vcl::Stdctrls::TCheckBox* CBRotate;
	Vcl::Comctrls::TPageControl* PageVertex;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Comctrls::TTabSheet* TabVertexFormat;
	Vcl::Stdctrls::TLabel* lblVertexTitleA;
	Vcl::Stdctrls::TEdit* EditVertTitleA;
	Vcl::Stdctrls::TLabel* lblVertexTitleB;
	Vcl::Stdctrls::TEdit* EditVertTitleB;
	Vcl::Stdctrls::TLabel* lblVertexTitleC;
	Vcl::Stdctrls::TEdit* EditVertTitleC;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBoxPointerClick(System::TObject* Sender);
	void __fastcall ComboTStyleChange(System::TObject* Sender);
	void __fastcall ComboTLStyleChange(System::TObject* Sender);
	void __fastcall EditVertTitleAChange(System::TObject* Sender);
	void __fastcall EditVertTitleBChange(System::TObject* Sender);
	void __fastcall EditVertTitleCChange(System::TObject* Sender);
	void __fastcall CBoxColorEachClick(System::TObject* Sender);
	void __fastcall CBAxisIncrChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall CBAutoClick(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall CBRotateClick(System::TObject* Sender);
	void __fastcall PageVertexChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Vcltee::Teeternary::TTernarySeries* Ternary;
	Vcltee::Teetextshapeeditor::TTextShapeEditor* IVertex;
	Vcl::Forms::TCustomForm* Grid3DForm;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTernarySeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTernarySeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTernarySeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTernarySeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TTernarySeriesEditor* TernarySeriesEditor;
}	/* namespace Teeternaryedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETERNARYEDIT)
using namespace Vcltee::Teeternaryedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeternaryeditHPP
