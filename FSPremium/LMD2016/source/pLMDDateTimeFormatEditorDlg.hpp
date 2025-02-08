// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDDateTimeFormatEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmddatetimeformateditordlgHPP
#define PlmddatetimeformateditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDListBox.hpp>
#include <LMDClass.hpp>
#include <LMDCustomScrollBox.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDInformationLabel.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDSimpleLabel.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDBaseControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmddatetimeformateditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFrmDateTimePropertyEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFrmDateTimePropertyEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdlistbox::TLMDListBox* LMDListBox1;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TEdit* Edit1;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel1;
	Vcl::Stdctrls::TComboBox* ComboBox1;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel2;
	Lmdinformationlabel::TLMDInformationLabel* LMDInformationLabel1;
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall ComboBox1Change(System::TObject* Sender);
	
public:
	void __fastcall SetFormat(System::UnicodeString aValue);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDFrmDateTimePropertyEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDFrmDateTimePropertyEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDFrmDateTimePropertyEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFrmDateTimePropertyEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmddatetimeformateditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDDATETIMEFORMATEDITORDLG)
using namespace Plmddatetimeformateditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmddatetimeformateditordlgHPP
