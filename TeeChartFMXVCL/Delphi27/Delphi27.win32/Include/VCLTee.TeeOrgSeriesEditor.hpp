// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeOrgSeriesEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeorgserieseditorHPP
#define Vcltee_TeeorgserieseditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Math.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeConst.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeComma.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeCustomShapeEditor.hpp>
#include <VCLTee.TeeStringsEditor.hpp>
#include <VCLTee.TeeMargins.hpp>
#include <VCLTee.TeeOrgSeries.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeorgserieseditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TOrgSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TOrgSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Comctrls::TTabSheet* TabNodes;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TScrollBar* ScrollBar1;
	Vcl::Stdctrls::TScrollBar* ScrollBar2;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Comctrls::TPageControl* PageNodes;
	Vcl::Comctrls::TTabSheet* TabText;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TMemo* Memo1;
	Vcltee::Tecanvas::TComboFlat* ComboAlign;
	Vcltee::Tecanvas::TComboFlat* CBCursor;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Buttons::TSpeedButton* SBAdd;
	Vcl::Buttons::TSpeedButton* SBDelete;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Stdctrls::TCheckBox* CBAutoSize;
	Vcl::Stdctrls::TLabel* Label14;
	Vcl::Stdctrls::TLabel* Label15;
	Vcl::Stdctrls::TEdit* ECustWidth;
	Vcl::Stdctrls::TEdit* ECustHeight;
	Vcl::Comctrls::TUpDown* UDWidth;
	Vcl::Comctrls::TUpDown* UDHeight;
	Vcl::Stdctrls::TCheckBox* CBClip;
	Vcl::Stdctrls::TCheckBox* CBVisible;
	Vcl::Stdctrls::TLabel* Label2;
	Vcltee::Tecanvas::TComboFlat* CBLineStyle;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Comctrls::TTabSheet* TabMargins;
	Vcl::Buttons::TSpeedButton* SpeedButton3;
	Vcl::Stdctrls::TCheckBox* CBDefaultFormat;
	Vcl::Comctrls::TTreeView* TreeNodes;
	Vcl::Comctrls::TTabSheet* TabFormat;
	Vcl::Comctrls::TTabSheet* TabLines;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ScrollBar1Change(System::TObject* Sender);
	void __fastcall ScrollBar2Change(System::TObject* Sender);
	void __fastcall Memo1Change(System::TObject* Sender);
	void __fastcall ComboAlignChange(System::TObject* Sender);
	void __fastcall CBCursorChange(System::TObject* Sender);
	void __fastcall PageNodesChange(System::TObject* Sender);
	void __fastcall SBAddClick(System::TObject* Sender);
	void __fastcall LBNodesClick(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall SBDeleteClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ECustWidthChange(System::TObject* Sender);
	void __fastcall ECustHeightChange(System::TObject* Sender);
	void __fastcall CBAutoSizeClick(System::TObject* Sender);
	void __fastcall CBClipClick(System::TObject* Sender);
	void __fastcall CBVisibleClick(System::TObject* Sender);
	void __fastcall CBLineStyleChange(System::TObject* Sender);
	void __fastcall PageControl2Change(System::TObject* Sender);
	void __fastcall SpeedButton3Click(System::TObject* Sender);
	void __fastcall CBDefaultFormatClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Vcltee::Teecustomshapeeditor::TFormTeeShape* NodeEditor;
	Vcltee::Teemargins::TMarginsEditor* MarginsForm;
	Vcltee::Teecustomshapeeditor::TFormTeeShape* IFormatEditor;
	void __fastcall AddListNodes(Vcltee::Teeorgseries::TCustomOrgSeries* const Series, int Current);
	Vcltee::Teeorgseries::TOrgItem* __fastcall CurrentItem();
	void __fastcall SetupEditor(Vcltee::Teeorgseries::TCustomOrgSeries* const ASeries);
	void __fastcall ShowHideFormatTabs(bool DoShow);
	
protected:
	Vcltee::Teeorgseries::TCustomOrgSeries* Series;
	bool IChanging;
	int __fastcall CurrentIndex();
	void __fastcall TeeEvent(Vcltee::Teeprocs::TTeeEvent* Event);
	void __fastcall RefreshNode(int Index);
	virtual void __fastcall SetItemProperties(int Index);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TOrgSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TOrgSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TOrgSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TOrgSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
private:
	void *__ITeeEventListener;	// Vcltee::Teeprocs::ITeeEventListener 
	
public:
	operator Vcltee::Teeprocs::ITeeEventListener*(void) { return (Vcltee::Teeprocs::ITeeEventListener*)&__ITeeEventListener; }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeorgserieseditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEORGSERIESEDITOR)
using namespace Vcltee::Teeorgserieseditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeorgserieseditorHPP
