// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElXSectProp.pas' rev: 31.00 (Windows)

#ifndef PlmdelxsectpropHPP
#define PlmdelxsectpropHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Math.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <DesignEditors.hpp>
#include <DesignWindows.hpp>
#include <DsnConst.hpp>
#include <DesignIntf.hpp>
#include <LMDTypes.hpp>
#include <ElXHeader.hpp>
#include <ElXTreeCell.hpp>
#include <Vcl.StdCtrls.hpp>
#include <pLMDElXSectEdit.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <ElXPThemedControl.hpp>
#include <ElHeader.hpp>
#include <ElPanel.hpp>
#include <ElGroupBox.hpp>
#include <ElCLabel.hpp>
#include <ElLabel.hpp>
#include <ElSpin.hpp>
#include <ElEdits.hpp>
#include <ElVCLUtils.hpp>
#include <ElBtnEdit.hpp>
#include <ElCombos.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDUtils.hpp>
#include <ElBtnCtl.hpp>
#include <ElPopBtn.hpp>
#include <ElCGControl.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelxsectprop
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElXSectionsPropDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElXSectionsPropDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Dialogs::TOpenDialog* OpenDlg;
	Vcl::Dialogs::TSaveDialog* SaveDlg;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Forms::TScrollBox* ScrollBox1;
	Elgroupbox::TElGroupBox* GroupBox1;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TListBox* SecList;
	Vcl::Extctrls::TPanel* Panel2;
	Elgroupbox::TElGroupBox* GroupBox2;
	Elxheader::TElXHeader* TestHeader;
	Elpanel::TElPanel* ElPanel1;
	Elgroupbox::TElGroupBox* ElGroupBox1;
	Elpanel::TElPanel* ElPanel2;
	Elgroupbox::TElGroupBox* ElGroupBox2;
	Eledits::TElEdit* CellEdit;
	Elspin::TElSpinEdit* RowCountSE;
	Elspin::TElSpinEdit* RowHeightSE;
	Ellabel::TElLabel* ElLabel1;
	Ellabel::TElLabel* ElLabel2;
	Ellabel::TElLabel* ElLabel3;
	Elpanel::TElPanel* ElPanel3;
	Elcombos::TElComboBox* AlCB;
	Ellabel::TElLabel* ElLabel4;
	Elpopbtn::TElPopupButton* Button1;
	Elpopbtn::TElPopupButton* Button2;
	Elpopbtn::TElPopupButton* Button3;
	Elpopbtn::TElPopupButton* MergeBtn;
	Elpopbtn::TElPopupButton* SplitBtn;
	Elpopbtn::TElPopupButton* AddBtn;
	Elpopbtn::TElPopupButton* DeleteBtn;
	Elpopbtn::TElPopupButton* EditBtn;
	Elpopbtn::TElPopupButton* UpBtn;
	Elpopbtn::TElPopupButton* DownBtn;
	Elpopbtn::TElPopupButton* LoadBtn;
	Elpopbtn::TElPopupButton* SaveBtn;
	Elpopbtn::TElPopupButton* DuplicateBtn;
	Elpopbtn::TElPopupButton* ReindexBtn;
	Elpopbtn::TElGraphicButton* FontBtn;
	Vcl::Dialogs::TFontDialog* FontDialog1;
	void __fastcall LoadBtnClick(System::TObject* Sender);
	void __fastcall SaveBtnClick(System::TObject* Sender);
	void __fastcall EditBtnClick(System::TObject* Sender);
	void __fastcall AddBtnClick(System::TObject* Sender);
	void __fastcall DeleteBtnClick(System::TObject* Sender);
	void __fastcall UpBtnClick(System::TObject* Sender);
	void __fastcall DownBtnClick(System::TObject* Sender);
	void __fastcall SecListClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall SecListKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall SecListDblClick(System::TObject* Sender);
	void __fastcall DuplicateBtnClick(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall ReindexBtnClick(System::TObject* Sender);
	void __fastcall TestHeaderSectionCreate(Elxheader::TElXCustomHeader* Sender, Elxheader::TElXHeaderSection* Section);
	void __fastcall TestHeaderSectionDelete(Elxheader::TElXCustomHeader* Sender, Elxheader::TElXHeaderSection* Section);
	void __fastcall RowHeightSEChange(System::TObject* Sender);
	void __fastcall RowCountSEChange(System::TObject* Sender);
	void __fastcall CellEditChange(System::TObject* Sender);
	void __fastcall TestHeaderSectionCellClick(Elxheader::TElXCustomHeader* Sender, Elxheader::TElXHeaderSection* Section, Elxheader::TElXHeaderCell* Cell);
	void __fastcall TestHeaderSectionCellPostDraw(Elxheader::TElXCustomHeader* Sender, Vcl::Graphics::TCanvas* Canvas, Elxheader::TElXHeaderSection* Section, Elxheader::TElXHeaderCell* Cell, const System::Types::TRect &R, bool Pressed);
	void __fastcall TestHeaderMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SplitBtnClick(System::TObject* Sender);
	void __fastcall MergeBtnClick(System::TObject* Sender);
	void __fastcall AlCBChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CellEditPasteClipboardText(System::TObject* Sender, Lmdtypes::TLMDString &AClipboardText);
	void __fastcall FontBtnClick(System::TObject* Sender);
	
protected:
	void __fastcall ScrollCheck(void);
	
public:
	int ARow;
	int ACol;
	Elxtreecell::TElXTreeCustomCellRange* ACellRange;
	Elxheader::TElXHeaderSections* ASect;
	bool FCtrlPressed;
	bool FShiftPressed;
	void __fastcall FillSecList(void);
	void __fastcall SetData(void);
	void __fastcall GetData(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TElXSectionsPropDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TElXSectionsPropDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TElXSectionsPropDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElXSectionsPropDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdelxsectprop */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELXSECTPROP)
using namespace Plmdelxsectprop;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelxsectpropHPP
