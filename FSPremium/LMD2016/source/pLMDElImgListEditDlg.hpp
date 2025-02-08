// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElImgListEditDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdelimglisteditdlgHPP
#define PlmdelimglisteditdlgHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <LMDElConst.hpp>
#include <ElPanel.hpp>
#include <ElGroupBox.hpp>
#include <ElCheckItemGrp.hpp>
#include <ElXPThemedControl.hpp>
#include <ElBtnCtl.hpp>
#include <ElPopBtn.hpp>
#include <Vcl.StdCtrls.hpp>
#include <ElCLabel.hpp>
#include <ElLabel.hpp>
#include <ElScrollBox.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelimglisteditdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFormImgListEditDlg;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TImageOperation : unsigned char { ioCrop, ioStretch, ioCenter, ioCenterStretch, ioCenterCrop, ioDivideIntoFragment };

typedef System::Set<TImageOperation, TImageOperation::ioCrop, TImageOperation::ioDivideIntoFragment> TImageOperations;

class PASCALIMPLEMENTATION TFormImgListEditDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Elcheckitemgrp::TElRadioGroup* ElRadioGroup1;
	Elpanel::TElPanel* pBtns;
	Elpopbtn::TElPopupButton* OkButton;
	Elpopbtn::TElPopupButton* CancelButton;
	Ellabel::TElLabel* ElLabel1;
	Elscrollbox::TElScrollBox* ScrollBox;
	Vcl::Extctrls::TImage* Image;
	Elpanel::TElPanel* ElPanel2;
	Ellabel::TElLabel* lbDestInfo;
	Ellabel::TElLabel* lbSrcInfo;
	Elpanel::TElPanel* ElPanel1;
	void __fastcall FormCreate(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFormImgListEditDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFormImgListEditDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFormImgListEditDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFormImgListEditDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall GetProccesingImageOperation(const TImageOperations ImageOperations, Vcl::Graphics::TGraphic* Graphic, int SrcWidth, int SrcHeight, int DestWidth, int DestHeight, TImageOperation &RetCode);
}	/* namespace Plmdelimglisteditdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELIMGLISTEDITDLG)
using namespace Plmdelimglisteditdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelimglisteditdlgHPP
