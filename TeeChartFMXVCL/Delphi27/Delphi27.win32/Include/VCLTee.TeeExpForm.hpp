// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeExpForm.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeexpformHPP
#define Vcltee_TeeexpformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <System.SysUtils.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeGalleryPanel.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeConst.hpp>
#include <VCLTee.TeeSelectList.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeEditCha.hpp>
#include <VCLTee.EditChar.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeexpform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeDlgWizard;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTeeDlgWizard : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl;
	Vcl::Comctrls::TTabSheet* TabStyle;
	Vcl::Comctrls::TTabSheet* TableName;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Comctrls::TTabSheet* Buttons;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* Label6;
	Vcltee::Tecanvas::TComboFlat* cbLabelsFields;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabPreviewChart;
	Vcl::Extctrls::TPanel* Panel7;
	Vcl::Stdctrls::TCheckBox* CB3DOption;
	Vcl::Stdctrls::TCheckBox* CBShowLegendOption;
	Vcl::Stdctrls::TCheckBox* CBShowMarksOption;
	Vcl::Extctrls::TPanel* Panel8;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Extctrls::TImage* Image2;
	Vcl::Stdctrls::TLabel* LabelURL;
	Vcl::Extctrls::TPanel* Panel5;
	Vcl::Stdctrls::TButton* PrevButton;
	Vcl::Stdctrls::TButton* NextButton;
	Vcltee::Teegallerypanel::TChartGalleryPanel* tmpGallery;
	Vcl::Extctrls::TRadioGroup* RGDatabase;
	Vcltee::Tecanvas::TComboFlat* CBAlias;
	Vcl::Stdctrls::TLabel* Label5;
	Vcltee::Tecanvas::TComboFlat* CBTables;
	Vcl::Extctrls::TImage* Image1;
	Vcl::Stdctrls::TButton* HelpButton;
	Vcl::Stdctrls::TLabel* LabelDBStyle;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Stdctrls::TCheckBox* CBColorEach;
	Vcl::Stdctrls::TLabel* LabelAlias;
	Vcltee::Tecanvas::TComboFlat* CBDBStyle;
	Vcl::Comctrls::TTabSheet* TabFile;
	Vcl::Buttons::TSpeedButton* BBrowse;
	Vcl::Stdctrls::TRadioButton* RBFile;
	Vcl::Stdctrls::TEdit* EFile;
	Vcl::Stdctrls::TRadioButton* RBWeb;
	Vcl::Stdctrls::TEdit* EWeb;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Extctrls::TRadioGroup* RG3D;
	Vcl::Stdctrls::TCheckBox* CBSmooth;
	Vcl::Stdctrls::TButton* BTheme;
	Vcl::Stdctrls::TCheckBox* CBShowError;
	Vcl::Stdctrls::TMemo* MemoError;
	Vcl::Extctrls::TPanel* Panel6;
	Vcl::Stdctrls::TButton* CancelBtn;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CancelClick(System::TObject* Sender);
	void __fastcall PrevClick(System::TObject* Sender);
	void __fastcall NextClick(System::TObject* Sender);
	void __fastcall Image1Click(System::TObject* Sender);
	void __fastcall CB3DOptionClick(System::TObject* Sender);
	void __fastcall CBShowLegendOptionClick(System::TObject* Sender);
	void __fastcall CBShowMarksOptionClick(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall HelpButtonClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall LabelURLClick(System::TObject* Sender);
	void __fastcall RG3DClick(System::TObject* Sender);
	void __fastcall tmpGallerySelectedChart(System::TObject* Sender);
	void __fastcall CBTablesChange(System::TObject* Sender);
	void __fastcall CBAliasChange(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall CBDBStyleChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CBColorEachClick(System::TObject* Sender);
	void __fastcall BBrowseClick(System::TObject* Sender);
	void __fastcall RBFileClick(System::TObject* Sender);
	void __fastcall EFileChange(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall CBSmoothClick(System::TObject* Sender);
	void __fastcall BThemeClick(System::TObject* Sender);
	void __fastcall CBShowErrorClick(System::TObject* Sender);
	
private:
	System::UnicodeString LastFolder;
	System::UnicodeString BackupDir;
	Vcltee::Teeselectlist::TSelectListForm* IFields;
	Vcltee::Chart::TChartThemeClass ThemeClass;
	int NewChartPalette;
	void __fastcall ChangeGalleryPalette();
	void __fastcall CheckPreviewOptions();
	void __fastcall CreatePreviewChart();
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall PreviewChartDblClick(System::TObject* Sender);
	void __fastcall RefreshAlias();
	void __fastcall RefreshButtons();
	void __fastcall TryChangeFolder(const System::UnicodeString S);
	
public:
	Vcltee::Chart::TChart* PreviewChart;
	void __fastcall CopyPreviewChart(Vcltee::Chart::TCustomChart* &Chart);
	void __fastcall CreateSeries(System::Classes::TComponent* AOwner, Vcltee::Chart::TCustomChart* AChart, bool ShowData);
	void __fastcall LoadChart(Vcltee::Chart::TCustomChart* &Chart);
	bool __fastcall StyleBDE();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTeeDlgWizard(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTeeDlgWizard(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTeeDlgWizard() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTeeDlgWizard(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define TeeMsg_WizardTable1 L"Table1"
}	/* namespace Teeexpform */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEEXPFORM)
using namespace Vcltee::Teeexpform;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeexpformHPP
