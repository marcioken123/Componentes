// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDLineEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdlineeditordlgHPP
#define PlmdlineeditordlgHPP

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
#include <System.Variants.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDChartLine.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdlineeditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLineEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDLineEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* btCancel;
	Vcl::Stdctrls::TButton* btOK;
	Vcl::Stdctrls::TGroupBox* gbLineSample;
	Vcl::Extctrls::TPaintBox* pbLineSample;
	Vcl::Comctrls::TListView* ListView1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Controls::TImageList* ImageList1;
	Vcl::Comctrls::TTrackBar* TrackBar1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TButton* btColor;
	Vcl::Dialogs::TColorDialog* ColorDialog1;
	void __fastcall ListView1Click(System::TObject* Sender);
	void __fastcall TrackBar1Change(System::TObject* Sender);
	void __fastcall btColorClick(System::TObject* Sender);
	void __fastcall pbLineSamplePaint(System::TObject* Sender);
	
private:
	Lmdchartline::TLMDChartLine* FLine;
	System::Uitypes::TColor FLineColor;
	Vcl::Graphics::TPenStyle FLineStyle;
	int FLineWidth;
	void __fastcall DrawSampleLine(void);
	
public:
	bool __fastcall Edit(Lmdchartline::TLMDChartLine* ALine);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDLineEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDLineEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDLineEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLineEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDLineEditor* LMDLineEditor;
}	/* namespace Plmdlineeditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDLINEEDITORDLG)
using namespace Plmdlineeditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdlineeditordlgHPP
