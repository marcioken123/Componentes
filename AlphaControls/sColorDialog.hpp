// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sColorDialog.pas' rev: 27.00 (Windows)

#ifndef ScolordialogHPP
#define ScolordialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sSkinProvider.hpp>	// Pascal unit
#include <sBitBtn.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <sPanel.hpp>	// Pascal unit
#include <sMaskEdit.hpp>	// Pascal unit
#include <sCurrencyEdit.hpp>	// Pascal unit
#include <sLabel.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sSpeedButton.hpp>	// Pascal unit
#include <sGraphUtils.hpp>	// Pascal unit
#include <sCurrEdit.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <sCustomComboEdit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Scolordialog
{
//-- type declarations -------------------------------------------------------
typedef System::DynamicArray<System::Uitypes::TColor> TColorArray;

class DELPHICLASS TsColorDialogForm;
class PASCALIMPLEMENTATION TsColorDialogForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Sskinprovider::TsSkinProvider* sSkinProvider1;
	Sbitbtn::TsBitBtn* sBitBtn1;
	Sbitbtn::TsBitBtn* sBitBtn2;
	Spanel::TsPanel* ColorPanel;
	Spanel::TsPanel* GradPanel;
	Scurrencyedit::TsCurrencyEdit* sREdit;
	Scurrencyedit::TsCurrencyEdit* sGEdit;
	Scurrencyedit::TsCurrencyEdit* sBEdit;
	Sbitbtn::TsBitBtn* sBitBtn3;
	Sbitbtn::TsBitBtn* sBitBtn4;
	Slabel::TsLabel* sLabel1;
	Slabel::TsLabel* sLabel2;
	Scurrencyedit::TsCurrencyEdit* sHEdit;
	Scurrencyedit::TsCurrencyEdit* sSEdit;
	Scurrencyedit::TsCurrencyEdit* sVEdit;
	Spanel::TsColorsPanel* MainPal;
	Spanel::TsColorsPanel* AddPal;
	Scurrencyedit::TsCurrencyEdit* sEditDecimal;
	Smaskedit::TsMaskEdit* sEditHex;
	Slabel::TsLabel* sLabel4;
	Slabel::TsLabel* sLabel5;
	Slabel::TsLabel* sLabel6;
	Sbitbtn::TsBitBtn* sBitBtn5;
	Sspeedbutton::TsSpeedButton* sSpeedButton1;
	Vcl::Extctrls::TShape* SelectedPanel;
	void __fastcall sBitBtn2Click(System::TObject* Sender);
	void __fastcall sBitBtn1Click(System::TObject* Sender);
	void __fastcall CreateExtBmp(void);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ColorPanelPaint(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas);
	void __fastcall ColorPanelMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall ColorPanelMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall ColorPanelMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall GradPanelPaint(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas);
	void __fastcall GradPanelMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall GradPanelMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall GradPanelMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall MainPalChange(System::TObject* Sender);
	void __fastcall sEditHexKeyPress(System::TObject* Sender, System::WideChar &Key);
	int __fastcall GetColorCoord(const Sconst::TsColor C);
	void __fastcall FormPaint(System::TObject* Sender);
	void __fastcall sEditHexChange(System::TObject* Sender);
	void __fastcall sEditDecimalChange(System::TObject* Sender);
	void __fastcall sHEditChange(System::TObject* Sender);
	void __fastcall sREditChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall sBitBtn4Click(System::TObject* Sender);
	void __fastcall sBitBtn5Click(System::TObject* Sender);
	void __fastcall sBitBtn3Click(System::TObject* Sender);
	void __fastcall sSpeedButton1Click(System::TObject* Sender);
	void __fastcall PickFormPaint(System::TObject* Sender);
	void __fastcall PickFormMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall PickFormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall PickFormMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall MainPalDblClick(System::TObject* Sender);
	void __fastcall AddPalDblClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
public:
	Vcl::Graphics::TBitmap* TmpBmp;
	Vcl::Graphics::TBitmap* ExtBmp;
	TColorArray TopColors;
	Vcl::Dialogs::TColorDialog* Owner;
	Spanel::TsPanel* PickPanel;
	__fastcall virtual ~TsColorDialogForm(void);
	void __fastcall SetMarker(void);
	void __fastcall PaintCursor(int mX, int mY, Vcl::Graphics::TCanvas* Canvas);
	System::Uitypes::TColor __fastcall GradToColor(int Coord);
	void __fastcall SetCurrentColor(System::Uitypes::TColor c);
	void __fastcall SetInternalColor(int h, double s);
	void __fastcall SetColorFromEdit(System::Uitypes::TColor Color, bool &Flag);
	void __fastcall ExitPanels(void);
	void __fastcall InitLngCaptions(void);
	System::Types::TRect __fastcall MarkerRect(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TsColorDialogForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TsColorDialogForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsColorDialogForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TsColorDialogForm* sColorDialogForm;
}	/* namespace Scolordialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SCOLORDIALOG)
using namespace Scolordialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ScolordialogHPP
