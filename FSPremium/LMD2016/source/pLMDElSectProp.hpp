// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElSectProp.pas' rev: 31.00 (Windows)

#ifndef PlmdelsectpropHPP
#define PlmdelsectpropHPP

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
#include <ElHeader.hpp>
#include <Vcl.StdCtrls.hpp>
#include <pLMDElSectEdit.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <ElXPThemedControl.hpp>
#include <LMDUtils.hpp>
#include <ElBtnCtl.hpp>
#include <ElPopBtn.hpp>
#include <ElListBox.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelsectprop
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElSectionsPropDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElSectionsPropDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Dialogs::TOpenDialog* OpenDlg;
	Vcl::Dialogs::TSaveDialog* SaveDlg;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Elheader::TElHeader* TestHeader;
	Elpopbtn::TElPopupButton* Button2;
	Elpopbtn::TElPopupButton* Button3;
	Elpopbtn::TElPopupButton* AddBtn;
	Elpopbtn::TElPopupButton* DeleteBtn;
	Elpopbtn::TElPopupButton* EditBtn;
	Elpopbtn::TElPopupButton* UpBtn;
	Elpopbtn::TElPopupButton* DownBtn;
	Elpopbtn::TElPopupButton* LoadBtn;
	Elpopbtn::TElPopupButton* SaveBtn;
	Elpopbtn::TElPopupButton* DuplicateBtn;
	Elpopbtn::TElPopupButton* ReindexBtn;
	Ellistbox::TElListBox* SecList;
	Elpopbtn::TElPopupButton* Button1;
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
	
public:
	Elheader::TElHeaderSections* ASect;
	void __fastcall FillSecList(void);
	void __fastcall SetData(void);
	void __fastcall GetData(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TElSectionsPropDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TElSectionsPropDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TElSectionsPropDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElSectionsPropDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdelsectprop */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELSECTPROP)
using namespace Plmdelsectprop;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelsectpropHPP
