// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Print.Preview.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Print_PreviewHPP
#define Fmxtee_Print_PreviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <FMX.NumberBox.hpp>
#include <FMX.EditBox.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.ListBox.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Print.PreviewPanel.hpp>
#include <FMX.Edit.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Print
{
namespace Preview
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TChartPreview;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TChartPreview : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Stdctrls::TButton* BPrint;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Listbox::TComboBox* CBPrinters;
	Fmx::Stdctrls::TPanel* Panel2;
	Fmx::Stdctrls::TButton* BSetupPrinter;
	Fmx::Listbox::TComboBox* Orientation;
	Fmx::Listbox::TListBoxItem* LBPortrait;
	Fmx::Listbox::TListBoxItem* LBLandscape;
	Fmx::Stdctrls::TGroupBox* GBMargins;
	Fmx::Numberbox::TNumberBox* UDTop;
	Fmx::Numberbox::TNumberBox* UDBottom;
	Fmx::Numberbox::TNumberBox* UDLeft;
	Fmx::Numberbox::TNumberBox* UDRight;
	Fmx::Stdctrls::TCheckBox* CBProp;
	Fmx::Stdctrls::TButton* BReset;
	Fmx::Stdctrls::TCheckBox* ShowMargins;
	Fmx::Stdctrls::TCheckBox* CBPrintPanel;
	Fmx::Stdctrls::TCheckBox* CBSmooth;
	Fmx::Stdctrls::TGroupBox* ChangeDetailGroup;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TTrackBar* Resolution;
	Fmxtee::Print::Previewpanel::TTeePreviewPanel* TeePreviewPanel1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall BSetupPrinterClick(System::TObject* Sender);
	void __fastcall BPrintClick(System::TObject* Sender);
	void __fastcall OrientationChange(System::TObject* Sender);
	void __fastcall CBPropChange(System::TObject* Sender);
	void __fastcall BResetClick(System::TObject* Sender);
	void __fastcall ShowMarginsChange(System::TObject* Sender);
	void __fastcall CBPrintPanelChange(System::TObject* Sender);
	void __fastcall CBPrintersChange(System::TObject* Sender);
	void __fastcall UDTopChangeTracking(System::TObject* Sender);
	void __fastcall UDRightChangeTracking(System::TObject* Sender);
	void __fastcall UDBottomChangeTracking(System::TObject* Sender);
	void __fastcall UDLeftChangeTracking(System::TObject* Sender);
	void __fastcall CBSmoothChange(System::TObject* Sender);
	void __fastcall ResolutionChange(System::TObject* Sender);
	void __fastcall TeePreviewPanel1ChangeMargins(System::TObject* Sender, bool DisableProportional, const System::Types::TRectF &NewMargins);
	
private:
	bool ChangingProp;
	bool ChangingMargins;
	System::Types::TRectF OldMargins;
	void __fastcall ChangeMargin(Fmx::Numberbox::TNumberBox* const UpDown, float &APos, const float OtherSide);
	void __fastcall CheckOrientation();
	int __fastcall PrinterCount();
	void __fastcall RefreshPanel(Fmxtee::Procs::TCustomTeePanel* const APanel);
	void __fastcall ResetMargins();
	
public:
	__classmethod Fmx::Forms::TForm* __fastcall CreateEditor(System::Classes::TComponent* const AOwner, Fmxtee::Procs::TCustomTeePanel* const APanel);
	__classmethod void __fastcall Preview(System::Classes::TComponent* const AOwner, Fmxtee::Procs::TCustomTeePanel* const APanel);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TChartPreview(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TChartPreview(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TChartPreview() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Preview */
}	/* namespace Print */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_PRINT_PREVIEW)
using namespace Fmxtee::Print::Preview;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_PRINT)
using namespace Fmxtee::Print;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Print_PreviewHPP
