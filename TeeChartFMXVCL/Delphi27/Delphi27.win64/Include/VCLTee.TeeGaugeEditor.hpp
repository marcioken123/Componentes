// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeGaugeEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeegaugeeditorHPP
#define Vcltee_TeegaugeeditorHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeePoEdi.hpp>
#include <VCLTee.TeeEdiFont.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeGauges.hpp>
#include <VCLTee.TeeCircledEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teegaugeeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGaugeSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TGaugeSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcltee::Teependlg::TButtonPen* BTicks;
	Vcltee::Teependlg::TButtonPen* BMinor;
	Vcl::Stdctrls::TEdit* Edit2;
	Vcl::Comctrls::TUpDown* UpDown1;
	Vcl::Stdctrls::TEdit* Edit4;
	Vcl::Comctrls::TUpDown* UpDown3;
	Vcl::Stdctrls::TCheckBox* CheckBox4;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* Edit8;
	Vcl::Comctrls::TUpDown* UDValue;
	Vcl::Stdctrls::TEdit* Edit3;
	Vcl::Comctrls::TUpDown* UpDown2;
	Vcl::Stdctrls::TEdit* Edit5;
	Vcl::Comctrls::TUpDown* UpDown4;
	Vcl::Comctrls::TTabSheet* TabEndPoint;
	Vcl::Comctrls::TTabSheet* TabCenter;
	Vcl::Comctrls::TTabSheet* TabAxis;
	Vcl::Comctrls::TTabSheet* TabHand;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabLabels;
	Vcl::Comctrls::TTabSheet* TabFont;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TCheckBox* CheckBox1;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Stdctrls::TCheckBox* CBInside;
	Vcl::Stdctrls::TEdit* Edit11;
	Vcl::Comctrls::TUpDown* UDIncrement;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Stdctrls::TEdit* Edit7;
	Vcl::Comctrls::TUpDown* UDDist;
	Vcl::Stdctrls::TLabel* Label6;
	Vcltee::Tecanvas::TComboFlat* CBHandStyle;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* Edit9;
	Vcl::Comctrls::TUpDown* UDMin;
	Vcl::Stdctrls::TEdit* Edit10;
	Vcl::Comctrls::TUpDown* UDMax;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Comctrls::TTrackBar* TBRot;
	Vcl::Stdctrls::TLabel* LRot;
	Vcl::Comctrls::TTrackBar* TBTotal;
	Vcl::Stdctrls::TLabel* LTotal;
	Vcl::Comctrls::TTabSheet* TabBack;
	Vcl::Comctrls::TPageControl* PageControl3;
	Vcl::Comctrls::TTabSheet* TabSheet4;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabBrush;
	Vcl::Extctrls::TRadioGroup* RGShape;
	void __fastcall CheckBox1Click(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall CBHandStyleChange(System::TObject* Sender);
	void __fastcall CheckBox4Click(System::TObject* Sender);
	void __fastcall Edit2Change(System::TObject* Sender);
	void __fastcall Edit3Change(System::TObject* Sender);
	void __fastcall Edit4Change(System::TObject* Sender);
	void __fastcall Edit5Change(System::TObject* Sender);
	void __fastcall Edit7Change(System::TObject* Sender);
	void __fastcall Edit8Change(System::TObject* Sender);
	void __fastcall Edit9Change(System::TObject* Sender);
	void __fastcall Edit10Change(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBInsideClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Edit11Change(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall PageControl2Change(System::TObject* Sender);
	void __fastcall TBRotChange(System::TObject* Sender);
	void __fastcall TBTotalChange(System::TObject* Sender);
	void __fastcall PageControl3Change(System::TObject* Sender);
	void __fastcall RGShapeClick(System::TObject* Sender);
	
private:
	Vcltee::Teegauges::TGaugeSeries* Gauge;
	Vcltee::Teecirclededit::TCircledSeriesEditor* tmpCircled;
	bool __fastcall CanModifyAxis();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TGaugeSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TGaugeSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TGaugeSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGaugeSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teegaugeeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEGAUGEEDITOR)
using namespace Vcltee::Teegaugeeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeegaugeeditorHPP
