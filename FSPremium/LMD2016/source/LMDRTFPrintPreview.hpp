// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFPrintPreview.pas' rev: 31.00 (Windows)

#ifndef LmdrtfprintpreviewHPP
#define LmdrtfprintpreviewHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <LMDRTFRichEdit.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfprintpreview
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRichfrmPrintPreview;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRichfrmPrintPreview : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Comctrls::TToolButton* btnPrint;
	Vcl::Comctrls::TToolButton* ToolButton2;
	Vcl::Comctrls::TToolButton* btnFullPage;
	Vcl::Comctrls::TToolButton* btnFitPage;
	Vcl::Comctrls::TToolButton* ToolButton6;
	Vcl::Comctrls::TToolButton* btnExit;
	Vcl::Controls::TImageList* ImageList;
	Vcl::Forms::TScrollBox* ScrollBox;
	Vcl::Comctrls::TToolButton* btnPageProps;
	Vcl::Comctrls::TToolButton* ToolButton3;
	Vcl::Comctrls::TToolButton* btnRealSize;
	Vcl::Stdctrls::TScrollBar* VScrollBar;
	Vcl::Comctrls::TToolButton* btnExtendedPreview;
	Vcl::Stdctrls::TScrollBar* HScrollBar;
	Vcl::Buttons::TSpeedButton* btnPrev;
	Vcl::Buttons::TSpeedButton* btnLast;
	Vcl::Buttons::TSpeedButton* btnFirst;
	Vcl::Buttons::TSpeedButton* btnNext;
	void __fastcall btnExitClick(System::TObject* Sender);
	void __fastcall btnPrintClick(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall btnFullPageClick(System::TObject* Sender);
	void __fastcall btnFitPageClick(System::TObject* Sender);
	void __fastcall btnPagePropsClick(System::TObject* Sender);
	void __fastcall btnRealSizeClick(System::TObject* Sender);
	void __fastcall VScrollBarScroll(System::TObject* Sender, System::Uitypes::TScrollCode ScrollCode, int &ScrollPos);
	void __fastcall btnExtendedPreviewClick(System::TObject* Sender);
	void __fastcall HScrollBarScroll(System::TObject* Sender, System::Uitypes::TScrollCode ScrollCode, int &ScrollPos);
	void __fastcall btnFirstClick(System::TObject* Sender);
	void __fastcall btnPrevClick(System::TObject* Sender);
	void __fastcall btnNextClick(System::TObject* Sender);
	void __fastcall btnLastClick(System::TObject* Sender);
	
private:
	System::Classes::TList* FPages;
	Lmdrtfrichedit::TLMDCustomRichEdit* FRichEdit;
	int FLastArrange;
	int FVPrevScrollPos;
	int FHPrevScrollPos;
	bool FExtendedMode;
	int FColCount;
	int FRowCount;
	void __fastcall ShowPages(int aScrollPosition, bool aVisible);
	
public:
	__fastcall virtual TLMDRichfrmPrintPreview(System::Classes::TComponent* aOnwer);
	__fastcall virtual ~TLMDRichfrmPrintPreview(void);
	void __fastcall ArrangePages(int aType);
	void __fastcall ArrangePagesEx(int aRowCount, int aColCount);
	__classmethod bool __fastcall Execute(Lmdrtfrichedit::TLMDCustomRichEdit* aRichEdit);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDRichfrmPrintPreview(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRichfrmPrintPreview(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtfprintpreview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFPRINTPREVIEW)
using namespace Lmdrtfprintpreview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfprintpreviewHPP
