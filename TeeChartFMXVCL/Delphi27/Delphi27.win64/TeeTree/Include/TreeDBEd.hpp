// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeDBEd.pas' rev: 34.00 (Windows)

#ifndef TreedbedHPP
#define TreedbedHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <TeeTree.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <TeeDBTre.hpp>
#include <Data.DB.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeGDIPlus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Treedbed
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFormDBTree;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TFormDBTree : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TRadioButton* RadioButton1;
	Vcl::Stdctrls::TMemo* Memo2;
	Vcl::Stdctrls::TRadioButton* RadioButton2;
	Vcl::Stdctrls::TMemo* Memo4;
	Vcl::Stdctrls::TRadioButton* RadioButton3;
	Vcl::Stdctrls::TMemo* Memo6;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcltee::Tecanvas::TComboFlat* CBDataSet;
	Vcltee::Tecanvas::TComboFlat* ComboBox2;
	Vcltee::Tecanvas::TComboFlat* ComboBox3;
	Vcltee::Tecanvas::TComboFlat* ComboBox4;
	Vcl::Stdctrls::TLabel* Label6;
	Vcltee::Tecanvas::TComboFlat* ComboBox5;
	Vcl::Stdctrls::TLabel* Label7;
	Vcltee::Tecanvas::TComboFlat* ComboBox6;
	Vcl::Stdctrls::TButton* Button4;
	Vcl::Stdctrls::TButton* Button5;
	Vcl::Stdctrls::TButton* BApply;
	Vcl::Stdctrls::TButton* Button7;
	Vcl::Stdctrls::TCheckBox* CheckBox1;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TMemo* Memo1;
	Vcl::Stdctrls::TMemo* Memo3;
	Vcl::Stdctrls::TMemo* Memo5;
	Teetree::TTree* TreePreview;
	Teetree::TTreeNodeShape* TreeShape1;
	Teetree::TTreeNodeShape* TreeShape2;
	Teetree::TTreeNodeShape* TreeShape3;
	Teetree::TTreeNodeShape* TreeShape4;
	Teetree::TTreeConnection* TreeShape1_TreeShape2;
	Teetree::TTreeConnection* TreeShape1_TreeShape3;
	Teetree::TTreeConnection* TreeShape1_TreeShape4;
	Vcl::Stdctrls::TButton* BNewDataSet;
	Vcl::Stdctrls::TButton* Button6;
	Vcl::Stdctrls::TButton* Button8;
	Vcl::Stdctrls::TButton* Button9;
	Vcl::Stdctrls::TButton* Button10;
	void __fastcall RadioButton1Click(System::TObject* Sender);
	void __fastcall RadioButton2Click(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall RadioButton3Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Memo2Click(System::TObject* Sender);
	void __fastcall Memo4Click(System::TObject* Sender);
	void __fastcall Memo6Click(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall CBDataSetChange(System::TObject* Sender);
	void __fastcall ComboBox5Change(System::TObject* Sender);
	void __fastcall ComboBox2Change(System::TObject* Sender);
	void __fastcall ComboBox3Change(System::TObject* Sender);
	void __fastcall ComboBox4Change(System::TObject* Sender);
	void __fastcall ComboBox6Change(System::TObject* Sender);
	void __fastcall BApplyClick(System::TObject* Sender);
	void __fastcall Button7Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall Button5Click(System::TObject* Sender);
	void __fastcall CheckBox1Click(System::TObject* Sender);
	void __fastcall Button6Click(System::TObject* Sender);
	void __fastcall Button8Click(System::TObject* Sender);
	void __fastcall Button9Click(System::TObject* Sender);
	void __fastcall Button10Click(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Data::Db::TDataSet* ADataSet;
	System::UnicodeString ACodeField;
	System::UnicodeString AParentField;
	System::UnicodeString ATextFields;
	Data::Db::TDataSet* ADetail;
	System::UnicodeString ADetailFields;
	Teetree::TTreeNodeShape* AFormatMaster;
	Teetree::TTreeNodeShape* AHeaderMaster;
	Teetree::TTreeNodeShape* AFormatDetail;
	Teetree::TTreeNodeShape* AHeaderDetail;
	HIDESBASE void __fastcall Changed();
	void __fastcall EditShape(Teetree::TTreeNodeShape* AShape);
	void __fastcall FillDataSets(System::Classes::TStrings* AItems, bool MastersOnly, Data::Db::TDataSet* AMaster);
	void __fastcall FillFields(Data::Db::TDataSet* tmpDataSet, System::Classes::TStrings* AItems, bool OnlyNumeric);
	void __fastcall OnShowEditor(System::TObject* Sender);
	
public:
	Teedbtre::TCustomDBTree* Tree1;
	void __fastcall FillControls();
	void __fastcall FillTree();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFormDBTree(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFormDBTree(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFormDBTree() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFormDBTree(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::WideChar TreeMsg_FieldSeparator = (System::WideChar)(0x3b);
extern DELPHI_PACKAGE void __fastcall ShowDBTreeEditor(System::Classes::TComponent* Owner, Teedbtre::TCustomDBTree* ADBTree);
extern DELPHI_PACKAGE void __fastcall EditDBTree(System::Classes::TComponent* Owner, Teedbtre::TCustomDBTree* ATree);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ChooseFields(const System::UnicodeString AText, System::Classes::TStrings* AItems, const System::UnicodeString ACaption)/* overload */;
}	/* namespace Treedbed */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TREEDBED)
using namespace Treedbed;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreedbedHPP
