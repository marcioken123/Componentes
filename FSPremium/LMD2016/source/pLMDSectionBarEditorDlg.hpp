// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDSectionBarEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdsectionbareditordlgHPP
#define PlmdsectionbareditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <VCLEditors.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtDlgs.hpp>
#include <pLMDImageBox.hpp>
#include <Vcl.Menus.hpp>
#include <LMDSectionBarPopupMenu.hpp>
#include <LMDShSpinEdit.hpp>
#include <LMDBarBase.hpp>
#include <LMDSectionBar.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.CheckLst.hpp>
#include <Vcl.Buttons.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdsectionbareditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDfrmSectionBarEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDfrmSectionBarEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* grpSection;
	Vcl::Stdctrls::TButton* btnSectionAdd;
	Vcl::Stdctrls::TButton* btnSectionRename;
	Vcl::Stdctrls::TButton* btnSectionDelete;
	Vcl::Stdctrls::TButton* btnSectionMoveUp;
	Vcl::Stdctrls::TButton* btnSectionCopyImages;
	Vcl::Stdctrls::TGroupBox* grpItems;
	Vcl::Stdctrls::TLabel* LMDSimpleLabel6;
	Vcl::Stdctrls::TButton* btnItemAdd;
	Vcl::Stdctrls::TButton* btnSectionMoveDown;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* btnSectionClear;
	Vcl::Stdctrls::TButton* btnItemInsert;
	Vcl::Stdctrls::TButton* btnItemDelete;
	Vcl::Stdctrls::TButton* btnItemMoveUp;
	Vcl::Stdctrls::TButton* btnItemMoveDown;
	Vcl::Stdctrls::TButton* btnItemClear;
	Vcl::Stdctrls::TButton* btnItemRename;
	Vcl::Stdctrls::TButton* btnSectionInsert;
	Vcl::Stdctrls::TLabel* lbd;
	Vcl::Stdctrls::TLabel* acSmallImages;
	Vcl::Stdctrls::TEdit* edCaption;
	Vcl::Stdctrls::TEdit* edHint;
	Vcl::Stdctrls::TLabel* lblCaption;
	Vcl::Stdctrls::TLabel* lblHint;
	Vcl::Stdctrls::TLabel* lblTag;
	Vcl::Stdctrls::TLabel* lblCustomData;
	Vcl::Stdctrls::TEdit* edCustomData;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* edSectionCaption;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* edSectionHint;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* edSmall;
	Vcl::Stdctrls::TEdit* edLarge;
	Vcl::Checklst::TCheckListBox* lbOptions;
	Vcl::Buttons::TSpeedButton* btnSmall;
	Vcl::Buttons::TSpeedButton* btnLarge;
	Vcl::Stdctrls::TButton* btnCopyReadOnly;
	Vcl::Stdctrls::TButton* btnCopyAllowDown;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TButton* btnCopyLargeImages;
	Vcl::Stdctrls::TButton* btnFont;
	Vcl::Stdctrls::TButton* btnCopyFont;
	Lmdsectionbarpopupmenu::TLMDSectionBarPopupMenu* bbarMenu;
	Lmdsectionbar::TLMDSectionBar* bbar;
	Lmdshspinedit::TLMDShSpinEdit* edSectionTag;
	Lmdshspinedit::TLMDShSpinEdit* edTag;
	Plmdimagebox::TLMDImageCBox* cbSmall;
	Plmdimagebox::TLMDImageCBox* cbLarge;
	void __fastcall btnClick(System::TObject* Sender);
	void __fastcall bbarChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall lbOptionsClickCheck(System::TObject* Sender);
	void __fastcall btnimlClick(System::TObject* Sender);
	void __fastcall edKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall edExit(System::TObject* Sender);
	void __fastcall bbarItemClick(System::TObject* Sender, Lmdsectionbar::TLMDSectionBarSection* Section, Lmdsectionbar::TLMDSectionBarItem* Item);
	
public:
	int FEditItem;
	Designintf::_di_IDesigner FDesigner;
	void __fastcall UpdateData(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDfrmSectionBarEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDfrmSectionBarEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDfrmSectionBarEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDfrmSectionBarEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdsectionbareditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDSECTIONBAREDITORDLG)
using namespace Plmdsectionbareditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdsectionbareditordlgHPP
