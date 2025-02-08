// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDStdItemPropertiesEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdstditempropertieseditordlgHPP
#define PlmdstditempropertieseditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDWave.hpp>
#include <LMDShSpinEdit.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <LMDImageList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdstditempropertieseditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStdItemForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStdItemForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Extctrls::TNotebook* nb;
	Vcl::Stdctrls::TLabel* LMDSimpleLabel1;
	Vcl::Stdctrls::TLabel* IndexW;
	Vcl::Stdctrls::TLabel* LMDSimpleLabel3;
	Vcl::Stdctrls::TLabel* LMDSimpleLabel5;
	Vcl::Stdctrls::TLabel* LMDSimpleLabel2;
	Lmdshspinedit::TLMDShSpinEdit* edW;
	Vcl::Stdctrls::TButton* btnWchange;
	Vcl::Stdctrls::TEdit* descw;
	Vcl::Stdctrls::TCheckBox* compressedw;
	Vcl::Stdctrls::TLabel* LMDLabel1;
	Vcl::Stdctrls::TLabel* indexb;
	Vcl::Stdctrls::TLabel* LMDLabel4;
	Vcl::Stdctrls::TLabel* LMDLabel5;
	Vcl::Stdctrls::TLabel* dimLabel;
	Vcl::Extctrls::TImage* img;
	Vcl::Stdctrls::TLabel* LMDLabel2;
	Lmdshspinedit::TLMDShSpinEdit* edb;
	Vcl::Stdctrls::TButton* btnbChange;
	Vcl::Stdctrls::TCheckBox* compressedb;
	Vcl::Stdctrls::TEdit* descb;
	Vcl::Stdctrls::TLabel* LMDGLabel1;
	Vcl::Stdctrls::TLabel* indexg;
	Vcl::Stdctrls::TLabel* LMDGLabel4;
	Vcl::Stdctrls::TLabel* dimlabelg;
	Vcl::Stdctrls::TLabel* LMDGLabel2;
	Vcl::Stdctrls::TLabel* LMDGLabel5;
	Vcl::Stdctrls::TButton* btngChange;
	Vcl::Stdctrls::TCheckBox* compressedg;
	Vcl::Stdctrls::TEdit* descg;
	Lmdshspinedit::TLMDShSpinEdit* edg;
	Vcl::Stdctrls::TButton* clear;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TComboBox* cmbb;
	Vcl::Extctrls::TPanel* LMDSimplePanel1;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* IndexS;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* Label9;
	Lmdshspinedit::TLMDShSpinEdit* edS;
	Vcl::Stdctrls::TEdit* descS;
	Vcl::Stdctrls::TCheckBox* compressedS;
	Vcl::Stdctrls::TLabel* LMDSimpleLabel4;
	Vcl::Stdctrls::TLabel* l;
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Comctrls::TToolButton* ToolButton1;
	Vcl::Comctrls::TToolButton* ToolButton2;
	Vcl::Stdctrls::TMemo* Editor;
	Vcl::Menus::TPopupMenu* editmenu;
	Vcl::Menus::TMenuItem* Cut1;
	Vcl::Menus::TMenuItem* Copy1;
	Vcl::Menus::TMenuItem* Paste1;
	Vcl::Menus::TMenuItem* Delete1;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* Selectall1;
	Vcl::Menus::TPopupMenu* mfile;
	Vcl::Menus::TMenuItem* mnuOpen;
	Vcl::Menus::TMenuItem* mnuSave;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TLabel* lblWidth;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Stdctrls::TLabel* Label13;
	Vcl::Stdctrls::TCheckBox* Maske;
	Vcl::Stdctrls::TCheckBox* compress;
	Lmdshspinedit::TLMDShSpinEdit* ed3;
	Lmdshspinedit::TLMDShSpinEdit* ed2;
	Vcl::Stdctrls::TEdit* desc;
	Vcl::Stdctrls::TButton* LMDButton1;
	Vcl::Stdctrls::TComboBox* cmb;
	Lmdshspinedit::TLMDShSpinEdit* ed1;
	Vcl::Stdctrls::TLabel* Count;
	Vcl::Stdctrls::TCheckBox* mk;
	Vcl::Stdctrls::TComboBox* rows;
	Vcl::Stdctrls::TLabel* Label14;
	Vcl::Stdctrls::TLabel* lblsize;
	Vcl::Stdctrls::TButton* aviLoad;
	Vcl::Stdctrls::TButton* aviPlay;
	Vcl::Comctrls::TAnimate* Ani;
	Vcl::Stdctrls::TButton* btnConvert;
	Vcl::Stdctrls::TLabel* lblframes;
	Vcl::Stdctrls::TButton* Load;
	Vcl::Stdctrls::TButton* Save;
	Vcl::Stdctrls::TButton* Play;
	Vcl::Stdctrls::TButton* btnWClear;
	Vcl::Extctrls::TPanel* pnlWave;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Stdctrls::TLabel* format;
	Vcl::Stdctrls::TLabel* size;
	Vcl::Stdctrls::TLabel* bits;
	Vcl::Stdctrls::TLabel* Label23;
	Vcl::Stdctrls::TLabel* Channels;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* samplerate;
	void __fastcall btnWchangeClick(System::TObject* Sender);
	void __fastcall clearClick(System::TObject* Sender);
	void __fastcall nbPageChanged(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall OnEditClick(System::TObject* Sender);
	void __fastcall editmenuPopup(System::TObject* Sender);
	void __fastcall EditorChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall btnConvertClick(System::TObject* Sender);
	
public:
	Lmdwave::TLMDWave* cWave;
	Lmdimagelist::TLMDImageListItem* ImageListItem;
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDStdItemForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDStdItemForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDStdItemForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDStdItemForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdstditempropertieseditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDSTDITEMPROPERTIESEDITORDLG)
using namespace Plmdstditempropertieseditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdstditempropertieseditordlgHPP
