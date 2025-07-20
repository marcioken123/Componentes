// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeCoEd.pas' rev: 34.00 (Windows)

#ifndef TreecoedHPP
#define TreecoedHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <TeeTree.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeEdiGrad.hpp>
#include <VCLTee.TeeCustomShapeEditor.hpp>

//-- user supplied -----------------------------------------------------------

namespace Treecoed
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TConnectionEditor;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TConnectionEditorProc)(Teetree::TTreeConnection* Sender);

class PASCALIMPLEMENTATION TConnectionEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Extctrls::TRadioGroup* RGStyle;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Extctrls::TRadioGroup* RGFromStyle;
	Vcl::Stdctrls::TButton* Button4;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Comctrls::TUpDown* UpDownFrom;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Extctrls::TRadioGroup* RGToStyle;
	Vcl::Stdctrls::TButton* Button6;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* Edit2;
	Vcl::Comctrls::TUpDown* UpDownTo;
	Vcl::Comctrls::TTabSheet* TabSheet4;
	Vcltee::Tecanvas::TButtonColor* BFromColor;
	Vcltee::Tecanvas::TButtonColor* BToColor;
	Vcltee::Teependlg::TButtonPen* ButtonPen1;
	Vcl::Stdctrls::TCheckBox* CheckBox1;
	Vcltee::Teependlg::TButtonPen* ButtonPen2;
	Vcltee::Teependlg::TButtonPen* ButtonPen3;
	Vcl::Comctrls::TTabSheet* TabSheet5;
	Vcl::Stdctrls::TListBox* LBPoints;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TGroupBox* GroupX;
	Vcl::Stdctrls::TGroupBox* GroupY;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* EXValue;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TEdit* EYValue;
	Vcl::Stdctrls::TRadioButton* RBFixedX;
	Vcl::Stdctrls::TRadioButton* RBRelFromX;
	Vcl::Stdctrls::TRadioButton* RBPrevX;
	Vcl::Stdctrls::TRadioButton* RBNextX;
	Vcl::Stdctrls::TRadioButton* RBNextY;
	Vcl::Stdctrls::TRadioButton* RBPrevY;
	Vcl::Stdctrls::TRadioButton* RBRelFromY;
	Vcl::Stdctrls::TRadioButton* RBFixedY;
	Vcl::Comctrls::TUpDown* UDX;
	Vcl::Comctrls::TUpDown* UDY;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Buttons::TSpeedButton* BDeletePoint;
	Vcl::Stdctrls::TRadioButton* RBRelToX;
	Vcl::Stdctrls::TRadioButton* RBRelToY;
	Vcl::Stdctrls::TCheckBox* CBAutoPoint;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* BBack;
	Vcl::Stdctrls::TCheckBox* CBBack;
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button5Click(System::TObject* Sender);
	void __fastcall Button6Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall Edit2Change(System::TObject* Sender);
	void __fastcall RGStyleClick(System::TObject* Sender);
	void __fastcall RGFromStyleClick(System::TObject* Sender);
	void __fastcall RGToStyleClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall CheckBox1Click(System::TObject* Sender);
	void __fastcall LBPointsClick(System::TObject* Sender);
	void __fastcall RBAutoXClick(System::TObject* Sender);
	void __fastcall EXValueChange(System::TObject* Sender);
	void __fastcall EYValueChange(System::TObject* Sender);
	void __fastcall RBAutoYClick(System::TObject* Sender);
	void __fastcall BDeletePointClick(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall CBAutoPointClick(System::TObject* Sender);
	void __fastcall BBackClick(System::TObject* Sender);
	void __fastcall CBBackClick(System::TObject* Sender);
	
private:
	bool Creating;
	void __fastcall ClearAllRadios();
	void __fastcall FillPoints();
	void __fastcall SetArrowFromBorder(Teetree::TTreeConnection* Sender);
	void __fastcall SetArrowFromBrush(Teetree::TTreeConnection* Sender);
	void __fastcall SetArrowFromSize(Teetree::TTreeConnection* Sender);
	void __fastcall SetArrowFromStyle(Teetree::TTreeConnection* Sender);
	void __fastcall SetArrowToBorder(Teetree::TTreeConnection* Sender);
	void __fastcall SetArrowToBrush(Teetree::TTreeConnection* Sender);
	void __fastcall SetArrowToSize(Teetree::TTreeConnection* Sender);
	void __fastcall SetArrowToStyle(Teetree::TTreeConnection* Sender);
	void __fastcall SetConnectionBorder(Teetree::TTreeConnection* Sender);
	void __fastcall SetConnectionStyle(Teetree::TTreeConnection* Sender);
	void __fastcall SetOther(TConnectionEditorProc Proc);
	void __fastcall SetStyleControls();
	
public:
	bool Multiple;
	Teetree::TTreeConnection* Connection;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TConnectionEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TConnectionEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TConnectionEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TConnectionEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall EditTreeConnection(System::Classes::TComponent* AOwner, Teetree::TTreeConnection* AConnection, bool ChangeMultiple = false);
}	/* namespace Treecoed */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TREECOED)
using namespace Treecoed;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreecoedHPP
