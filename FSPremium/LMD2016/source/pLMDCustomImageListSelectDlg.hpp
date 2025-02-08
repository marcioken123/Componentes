// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDCustomImageListSelectDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdcustomimagelistselectdlgHPP
#define PlmdcustomimagelistselectdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <DesignIntf.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Consts.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Buttons.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDCont.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdcustomimagelistselectdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustImgListSelectDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustImgListSelectDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* LMDSimplePanel2;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TComboBox* cmb;
	Vcl::Extctrls::TPanel* LMDSimplePanel1;
	Vcl::Stdctrls::TButton* btnOk;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Comctrls::TListView* ll;
	Vcl::Controls::TImageList* ImageList1;
	Vcl::Stdctrls::TListBox* lv;
	Vcl::Comctrls::THeaderControl* Header;
	void __fastcall lbDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall cmbChange(System::TObject* Sender);
	void __fastcall lbDblClick(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall llClick(System::TObject* Sender);
	void __fastcall lvCustomDrawItem(Vcl::Comctrls::TCustomListView* Sender, Vcl::Comctrls::TListItem* Item, Vcl::Comctrls::TCustomDrawState State, bool &DefaultDraw);
	
private:
	Vcl::Graphics::TBitmap* tmp;
	bool FSelect;
	Designintf::_di_IDesigner FDesigner;
	void __fastcall SetMultiSelect(bool aValue);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall GetLists(const System::UnicodeString S);
	void __fastcall AddItem(const System::UnicodeString sType, int sCount, const System::UnicodeString sName, System::TObject* sData);
	
public:
	Vcl::Imglist::TCustomImageList* FImageList;
	void __fastcall AddImageLists(void);
	void __fastcall SetLabels(void);
	void __fastcall SetListIndex(int nr);
	__property Designintf::_di_IDesigner Design = {read=FDesigner, write=FDesigner};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList};
	__property bool MultiSelect = {read=FSelect, write=SetMultiSelect, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDCustImgListSelectDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDCustImgListSelectDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDCustImgListSelectDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustImgListSelectDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdcustomimagelistselectdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCUSTOMIMAGELISTSELECTDLG)
using namespace Plmdcustomimagelistselectdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdcustomimagelistselectdlgHPP
