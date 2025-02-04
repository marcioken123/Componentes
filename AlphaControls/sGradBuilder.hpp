// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sGradBuilder.pas' rev: 27.00 (Windows)

#ifndef SgradbuilderHPP
#define SgradbuilderHPP

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
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <sGradient.hpp>	// Pascal unit
#include <sSkinProvider.hpp>	// Pascal unit
#include <sPanel.hpp>	// Pascal unit
#include <sLabel.hpp>	// Pascal unit
#include <sButton.hpp>	// Pascal unit
#include <sComboBox.hpp>	// Pascal unit
#include <sRadioButton.hpp>	// Pascal unit
#include <sDialogs.hpp>	// Pascal unit
#include <sPageControl.hpp>	// Pascal unit
#include <sColorSelect.hpp>	// Pascal unit
#include <sSpeedButton.hpp>	// Pascal unit
#include <sGroupBox.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sgradbuilder
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TGradPoint;
class PASCALIMPLEMENTATION TGradPoint : public Vcl::Extctrls::TPanel
{
	typedef Vcl::Extctrls::TPanel inherited;
	
public:
	int Number;
	__fastcall virtual TGradPoint(System::Classes::TComponent* AOwner);
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TGradPoint(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGradPoint(HWND ParentWindow) : Vcl::Extctrls::TPanel(ParentWindow) { }
	
};


typedef System::DynamicArray<TGradPoint*> TPointArray;

class DELPHICLASS TGradBuilder;
class PASCALIMPLEMENTATION TGradBuilder : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Menus::TMenuItem* Changecolor1;
	Vcl::Menus::TMenuItem* Delete1;
	Sskinprovider::TsSkinProvider* sSkinProvider1;
	Sbutton::TsButton* BitBtn1;
	Sbutton::TsButton* sButton1;
	Sbutton::TsButton* sButton2;
	Sradiobutton::TsRadioButton* sRadioButton1;
	Sradiobutton::TsRadioButton* sRadioButton2;
	Sradiobutton::TsRadioButton* sRadioButton3;
	Sgroupbox::TsGroupBox* sGroupBox1;
	Spanel::TsPanel* PaintPanel;
	Vcl::Extctrls::TPaintBox* PaintBox1;
	Spanel::TsPanel* Panel2;
	Spanel::TsPanel* TemplatePanel;
	Sgroupbox::TsGroupBox* sGroupBox2;
	Spanel::TsPanel* sPanel1;
	Vcl::Extctrls::TPaintBox* PaintBox2;
	Scolorselect::TsColorSelect* sColorSelect5;
	Scolorselect::TsColorSelect* sColorSelect3;
	Scolorselect::TsColorSelect* sColorSelect4;
	Scolorselect::TsColorSelect* sColorSelect2;
	Scolorselect::TsColorSelect* sColorSelect1;
	void __fastcall Panel2Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall TemplatePanelMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall TemplatePanelMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall Changecolor1Click(System::TObject* Sender);
	void __fastcall PopupMenu1Popup(System::TObject* Sender);
	void __fastcall Delete1Click(System::TObject* Sender);
	void __fastcall PaintBox1Paint(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall BitBtn1Click(System::TObject* Sender);
	void __fastcall TemplatePanelMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall TemplatePanelDblClick(System::TObject* Sender);
	void __fastcall sButton1Click(System::TObject* Sender);
	void __fastcall sButton2Click(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall sRadioButton1Click(System::TObject* Sender);
	void __fastcall sColorSelect1Change(System::TObject* Sender);
	
private:
	int __fastcall GetDirection(void);
	void __fastcall SetDirection(const int Value);
	void __fastcall MakefirstPoints(void);
	void __fastcall InitTriangles(void);
	
public:
	TPointArray a;
	Sconst::TsGradArray g;
	TGradPoint* LastPoint;
	System::Uitypes::TModalResult ModalResult;
	Sconst::TsGradArray CurrentArray;
	Vcl::Dialogs::TColorDialog* ColorDialog1;
	System::UnicodeString __fastcall AsString(void);
	void __fastcall LoadFromArray(Sconst::TsGradArray NewArray);
	void __fastcall ReCalcData(void);
	void __fastcall NewPoint(Spanel::TsPanel* Owner, int y, System::Uitypes::TColor Color);
	void __fastcall DeleteFromArray(TGradPoint* p);
	void __fastcall Reinit(void);
	__property int Direction = {read=GetDirection, write=SetDirection, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TGradBuilder(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TGradBuilder(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TGradBuilder(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGradBuilder(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 PointHeight = System::Int8(0x6);
extern DELPHI_PACKAGE TGradBuilder* GradBuilder;
extern DELPHI_PACKAGE bool NoMouse;
extern DELPHI_PACKAGE Vcl::Dialogs::TColorDialog* ColorDialog;
extern DELPHI_PACKAGE void __fastcall CreateEditorForm(void)/* overload */;
extern DELPHI_PACKAGE void __fastcall CreateEditorForm(Vcl::Dialogs::TColorDialog* CustomDlg)/* overload */;
extern DELPHI_PACKAGE void __fastcall KillForm(void);
}	/* namespace Sgradbuilder */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SGRADBUILDER)
using namespace Sgradbuilder;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SgradbuilderHPP
