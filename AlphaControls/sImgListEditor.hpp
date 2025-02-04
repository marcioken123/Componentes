// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sImgListEditor.pas' rev: 27.00 (Windows)

#ifndef SimglisteditorHPP
#define SimglisteditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.ActnList.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <Vcl.ExtDlgs.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <sPanel.hpp>	// Pascal unit
#include <sSpeedButton.hpp>	// Pascal unit
#include <acAlphaImageList.hpp>	// Pascal unit
#include <sSkinProvider.hpp>	// Pascal unit
#include <sListView.hpp>	// Pascal unit
#include <sBitBtn.hpp>	// Pascal unit
#include <sButton.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Simglisteditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFormImgListEditor;
class PASCALIMPLEMENTATION TFormImgListEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Sbitbtn::TsBitBtn* sBitBtn5;
	Sbitbtn::TsBitBtn* sBitBtn6;
	Sbitbtn::TsBitBtn* sBitBtn7;
	Acalphaimagelist::TsAlphaImageList* ImageList1;
	Vcl::Extdlgs::TOpenPictureDialog* OpenPictureDialog1;
	Slistview::TsListView* ListView1;
	Sspeedbutton::TsSpeedButton* SpeedButton1;
	Sspeedbutton::TsSpeedButton* SpeedButton2;
	Sspeedbutton::TsSpeedButton* SpeedButton3;
	Sspeedbutton::TsSpeedButton* SpeedButton4;
	Sskinprovider::TsSkinProvider* sSkinProvider1;
	Acalphaimagelist::TsAlphaImageList* sAlphaImageList1;
	Vcl::Dialogs::TSaveDialog* SaveDialog1;
	Sspeedbutton::TsSpeedButton* SpeedButton5;
	Sspeedbutton::TsSpeedButton* SpeedButton6;
	void __fastcall ListView1DragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall ListView1DragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ListView1Click(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall SpeedButton3Click(System::TObject* Sender);
	void __fastcall sBitBtn5Click(System::TObject* Sender);
	void __fastcall sBitBtn6Click(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall ListView1KeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall sBitBtn7Click(System::TObject* Sender);
	void __fastcall SpeedButton4Click(System::TObject* Sender);
	void __fastcall SpeedButton5Click(System::TObject* Sender);
	void __fastcall CheckScroll(System::TObject* Sender);
	void __fastcall SpeedButton6Click(System::TObject* Sender);
	
public:
	Acalphaimagelist::TsAlphaImageList* sImageList;
	MESSAGE void __fastcall WMDropFiles(Winapi::Messages::TWMDropFiles &Msg);
	void __fastcall ListViewRefresh(void);
	void __fastcall InitFromImgList(Acalphaimagelist::TsAlphaImageList* ImgList);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFormImgListEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFormImgListEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFormImgListEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFormImgListEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TFormImgListEditor* FormImgListEditor;
extern DELPHI_PACKAGE Vcl::Extctrls::TTimer* ScrollTimer;
}	/* namespace Simglisteditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SIMGLISTEDITOR)
using namespace Simglisteditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SimglisteditorHPP
