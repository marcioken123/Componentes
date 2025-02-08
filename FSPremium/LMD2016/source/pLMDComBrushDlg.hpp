// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDComBrushDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdcombrushdlgHPP
#define PlmdcombrushdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <pLMDColorBox.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdcombrushdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDComBrushEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDComBrushEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TComboBox* cmb;
	Vcl::Extctrls::TBevel* LMDDrawEdge1;
	Vcl::Extctrls::TShape* test;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TButton* btnCancel;
	Plmdcolorbox::TLMDColorBox* cmbc;
	Vcl::Buttons::TSpeedButton* btnColor;
	Vcl::Dialogs::TColorDialog* dlgColor;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall cmbcChange(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall cmbChange(System::TObject* Sender);
	void __fastcall btnColorClick(System::TObject* Sender);
	
private:
	bool FShow;
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDComBrushEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDComBrushEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDComBrushEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDComBrushEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdcombrushdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCOMBRUSHDLG)
using namespace Plmdcombrushdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdcombrushdlgHPP
