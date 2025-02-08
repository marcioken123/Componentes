// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDBmpRegionEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdbmpregioneditordlgHPP
#define PlmdbmpregioneditordlgHPP

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
#include <Vcl.ExtDlgs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <LMDClass.hpp>
#include <LMDCont.hpp>
#include <LMDCustomControl.hpp>
#include <LMDThemes.hpp>
#include <LMDProgressFill.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDBaseMeter.hpp>
#include <LMDCustomProgressFill.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomScrollBox.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDCustomButton.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDComboBox.hpp>
#include <LMDSimplePanel.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDButton.hpp>
#include <LMDSimpleLabel.hpp>
#include <LMDScrollBox.hpp>
#include <LMDCheckBox.hpp>
#include <LMDButtonControl.hpp>
#include <LMDRegionMask.hpp>
#include <LMDCustomCheckBox.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDImageList.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDBaseController.hpp>
#include <LMDCustomContainer.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDThemedComboBox.hpp>
#include <LMDControl.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdbmpregioneditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDfrmRegionFromBMPdlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDfrmRegionFromBMPdlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extdlgs::TOpenPictureDialog* openpic;
	Vcl::Comctrls::TPageControl* TabbedNotebook1;
	Lmdspeedbutton::TLMDSpeedButton* LoadButton;
	Lmdsimplelabel::TLMDSimpleLabel* DimLabel;
	Lmdscrollbox::TLMDScrollBox* LMDScrollBox1;
	Vcl::Extctrls::TImage* Image1;
	Lmdsimplepanel::TLMDSimplePanel* LMDSimplePanel1;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel1;
	Lmdsimplelabel::TLMDSimpleLabel* cc;
	Vcl::Stdctrls::TListBox* cl;
	Lmdsimplepanel::TLMDSimplePanel* LMDSimplePanel2;
	Vcl::Extctrls::TPaintBox* zoom;
	Lmdsimplelabel::TLMDSimpleLabel* ViewLabel;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel4;
	Lmdsimplepanel::TLMDSimplePanel* LMDSimplePanel3;
	Lmdsimplelabel::TLMDSimpleLabel* bsLabel;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel3;
	Lmdcombobox::TLMDComboBox* cb;
	Lmdcheckbox::TLMDCheckBox* ccb;
	Lmdcombobox::TLMDComboBox* colb;
	Lmdspeedbutton::TLMDSpeedButton* BuildButton;
	Lmdprogressfill::TLMDProgressFill* Progress;
	Lmdbutton::TLMDButton* LMDButton1;
	Lmdbutton::TLMDButton* OKButton;
	Lmdimagelist::TLMDImageList* LMDImageList1;
	Lmdcombobox::TLMDComboBox* cb2;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	void __fastcall Image1MouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormPaint(System::TObject* Sender);
	void __fastcall BuildButtonClick(System::TObject* Sender);
	void __fastcall clKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall clDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall clMeasureItem(Vcl::Controls::TWinControl* Control, int Index, int &Height);
	void __fastcall CancelButtonClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Image1MouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall zoomMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall zoomMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall clKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall LoadButtonClick(System::TObject* Sender);
	void __fastcall OKButtonClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall ccbChange(System::TObject* Sender);
	void __fastcall colbChange(System::TObject* Sender);
	void __fastcall cbChange(System::TObject* Sender);
	
private:
	int StartP;
	int POfAll;
	
public:
	bool createAllBorders;
	Lmdregionmask::TLMDRegionMask* RgnMask;
	HRGN __fastcall CreateRgnFromBitmap2(Vcl::Graphics::TBitmap* bmp, const System::Uitypes::TColor *transcol, const int transcol_High, int numtranscol);
	void __fastcall PaintRGNBorder2(Vcl::Graphics::TBitmap* bmp, HRGN region, int style);
	void __fastcall PaintRGNBorder3(Vcl::Graphics::TBitmap* bmp, HRGN region, int style);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDfrmRegionFromBMPdlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDfrmRegionFromBMPdlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDfrmRegionFromBMPdlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDfrmRegionFromBMPdlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdbmpregioneditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDBMPREGIONEDITORDLG)
using namespace Plmdbmpregioneditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdbmpregioneditordlgHPP
