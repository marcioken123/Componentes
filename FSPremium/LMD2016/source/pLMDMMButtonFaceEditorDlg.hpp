// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDMMButtonFaceEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdmmbuttonfaceeditordlgHPP
#define PlmdmmbuttonfaceeditordlgHPP

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
#include <Vcl.ImgList.hpp>
#include <LMDGraph.hpp>
#include <LMDCont.hpp>
#include <LMDProcs.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDFormA.hpp>
#include <LMDCustomScrollBox.hpp>
#include <LMDListBox.hpp>
#include <LMDCustomButton.hpp>
#include <LMDButton.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDCustomMMButton.hpp>
#include <LMDButtonBase.hpp>
#include <LMDSimpleLabel.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDMMButtonFaceController.hpp>
#include <LMDBaseControl.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdmmbuttonfaceeditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDButtonFaceDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDButtonFaceDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdbutton::TLMDButton* SelectBtn;
	Lmdbutton::TLMDButton* OKButton;
	Lmdbutton::TLMDButton* CancelButton;
	Lmdlistbox::TLMDListBox* lb;
	Lmdbutton::TLMDButton* nopicture;
	Lmdbutton::TLMDButton* ClearAll;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel1;
	Lmdbutton::TLMDButton* sync;
	Lmdbutton::TLMDButton* synchot;
	Lmdbutton::TLMDButton* LMDButton1;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall lbDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall SelectBtnClick(System::TObject* Sender);
	void __fastcall nopictureClick(System::TObject* Sender);
	void __fastcall ClearAllClick(System::TObject* Sender);
	void __fastcall syncClick(System::TObject* Sender);
	void __fastcall lbResize(System::TObject* Sender);
	void __fastcall LMDButton1Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
public:
	Lmdbuttonbase::TLMDButtonFaceIndices FTempIndices;
	Lmdbuttonbase::TLMDButtonFaceIndices FIndices;
	Vcl::Imglist::TCustomImageList* FImageList;
	System::Word __fastcall GetHeighestItem(void);
	void __fastcall RefreshList(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDButtonFaceDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDButtonFaceDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDButtonFaceDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDButtonFaceDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdmmbuttonfaceeditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDMMBUTTONFACEEDITORDLG)
using namespace Plmdmmbuttonfaceeditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdmmbuttonfaceeditordlgHPP
