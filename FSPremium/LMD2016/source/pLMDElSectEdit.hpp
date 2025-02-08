// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElSectEdit.pas' rev: 31.00 (Windows)

#ifndef PlmdelsecteditHPP
#define PlmdelsecteditHPP

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
#include <ElHeader.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <ElCheckCtl.hpp>
#include <ElXPThemedControl.hpp>
#include <ElBtnCtl.hpp>
#include <ElPopBtn.hpp>
#include <ElPanel.hpp>
#include <ElGroupBox.hpp>
#include <ElCheckItemGrp.hpp>
#include <ElEdits.hpp>
#include <ElBtnEdit.hpp>
#include <ElCombos.hpp>
#include <ElCGControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelsectedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSectEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSectEdit : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TGroupBox* GroupBox3;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Stdctrls::TComboBox* StyleCombo;
	Elpopbtn::TElPopupButton* ElPopupButton1;
	Elpopbtn::TElPopupButton* ElPopupButton2;
	Elcheckctl::TElCheckBox* VisCB;
	Elcheckctl::TElCheckBox* ExpandableCB;
	Elcheckctl::TElCheckBox* ExpandedCB;
	Elcheckctl::TElCheckBox* FilterCB;
	Elcheckctl::TElCheckBox* LookupCB;
	Elcheckctl::TElCheckBox* ClickCB;
	Elcheckctl::TElCheckBox* ClickSelCB;
	Elcheckctl::TElCheckBox* ResizeCB;
	Elcheckctl::TElCheckBox* PswCB;
	Elcheckctl::TElCheckBox* EditCB;
	Elcheckctl::TElCheckBox* AutosizeCB;
	Elcheckctl::TElCheckBox* ShowSortMarkCB;
	Elcheckitemgrp::TElRadioGroup* LayoutRG;
	Elcheckitemgrp::TElRadioGroup* AlignRG;
	Elcheckitemgrp::TElRadioGroup* ImAlignRG;
	Elcheckitemgrp::TElRadioGroup* SortRG;
	Eledits::TElEdit* ImIndexEdit;
	Eledits::TElEdit* TextEB;
	Eledits::TElEdit* FieldEdit;
	Eledits::TElEdit* HintEdit;
	Eledits::TElEdit* WidthEB;
	Eledits::TElEdit* MinWidthEB;
	Eledits::TElEdit* MaxWidthEB;
	Elcombos::TElComboBox* ColTypeCB;
	Elcombos::TElComboBox* PopupCombo;
	Elcombos::TElComboBox* ParentCombo;
	Elpopbtn::TElGraphicButton* FontBtn;
	Vcl::Dialogs::TFontDialog* FontDialog1;
	void __fastcall ExpandableCBClick(System::TObject* Sender);
	void __fastcall FilterCBClick(System::TObject* Sender);
	void __fastcall LookupCBClick(System::TObject* Sender);
	void __fastcall FontBtnClick(System::TObject* Sender);
	
public:
	Elheader::TElHeaderSection* Item;
	Elheader::TElHeaderSections* Items;
	Vcl::Forms::TCustomForm* Form;
	void __fastcall SetData(void);
	void __fastcall GetData(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSectEdit(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSectEdit(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSectEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSectEdit(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TSectEdit* SectEdit;
}	/* namespace Plmdelsectedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELSECTEDIT)
using namespace Plmdelsectedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelsecteditHPP
