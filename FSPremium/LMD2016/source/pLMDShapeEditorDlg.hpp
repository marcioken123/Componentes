// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDShapeEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdshapeeditordlgHPP
#define PlmdshapeeditordlgHPP

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
#include <LMDClass.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseShape.hpp>
#include <LMDShapeControl.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDFormStyler.hpp>
#include <LMDBaseControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdshapeeditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShapeEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDShapeEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TComboBox* pred;
	Lmdshapecontrol::TLMDShapeControl* test;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TButton* btnCancel;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall predChange(System::TObject* Sender);
	
private:
	bool FShow;
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDShapeEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDShapeEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDShapeEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDShapeEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdshapeeditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDSHAPEEDITORDLG)
using namespace Plmdshapeeditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdshapeeditordlgHPP
