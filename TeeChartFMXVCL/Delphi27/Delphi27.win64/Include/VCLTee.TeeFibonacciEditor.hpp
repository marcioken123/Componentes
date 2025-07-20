// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeFibonacciEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeefibonaccieditorHPP
#define Vcltee_TeefibonaccieditorHPP

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
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeToolSeriesEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeFibonacci.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teefibonaccieditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFibonacciEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TFibonacciEditor : public Vcltee::Teetoolseriesedit::TSeriesToolEditor
{
	typedef Vcltee::Teetoolseriesedit::TSeriesToolEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcltee::Teependlg::TButtonPen* BTrendPen;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* EXStart;
	Vcl::Stdctrls::TEdit* EYStart;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TEdit* EXEnd;
	Vcl::Stdctrls::TEdit* EYEnd;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* BRemoveLevel;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Stdctrls::TGroupBox* GBLevels;
	Vcl::Stdctrls::TEdit* ELevel;
	Vcl::Comctrls::TUpDown* UDLevel;
	Vcl::Stdctrls::TEdit* ELevelValue;
	Vcltee::Teependlg::TButtonPen* BLevelPen;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Stdctrls::TCheckBox* CBLabels;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TEdit* EAngle;
	Vcl::Comctrls::TUpDown* UDAngle;
	Vcl::Stdctrls::TComboBox* CBStyle;
	Vcl::Stdctrls::TLabel* Label7;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBLabelsClick(System::TObject* Sender);
	void __fastcall EXStartChange(System::TObject* Sender);
	void __fastcall EYStartChange(System::TObject* Sender);
	void __fastcall EXEndChange(System::TObject* Sender);
	void __fastcall EYEndChange(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall ELevelChange(System::TObject* Sender);
	void __fastcall BRemoveLevelClick(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall EAngleChange(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	void __fastcall ELevelValueChange(System::TObject* Sender);
	
private:
	Vcltee::Teefibonacci::TFibonacciTool* Fibonacci;
	void __fastcall SetLevel(int Index);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFibonacciEditor(System::Classes::TComponent* AOwner) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFibonacciEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFibonacciEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFibonacciEditor(HWND ParentWindow) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teefibonaccieditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEFIBONACCIEDITOR)
using namespace Vcltee::Teefibonaccieditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeefibonaccieditorHPP
