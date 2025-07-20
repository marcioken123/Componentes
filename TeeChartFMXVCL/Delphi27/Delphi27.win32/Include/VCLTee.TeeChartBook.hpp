// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeChartBook.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeechartbookHPP
#define Vcltee_TeechartbookHPP

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
#include <Vcl.Menus.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeComma.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teechartbook
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TChartBook;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TNewChartEvent)(TChartBook* Sender, Vcltee::Chart::TCustomChart* Chart);

typedef void __fastcall (__closure *TDeleteChartEvent)(TChartBook* Sender, Vcltee::Chart::TCustomChart* Chart, bool &Delete);

class PASCALIMPLEMENTATION TChartBook : public Vcl::Comctrls::TPageControl
{
	typedef Vcl::Comctrls::TPageControl inherited;
	
private:
	bool FToolbar;
	Vcl::Menus::TMenuItem* MenuToolbar;
	Vcl::Menus::TMenuItem* DeleteItem;
	TDeleteChartEvent FOnDelete;
	TNewChartEvent FOnNew;
	void __fastcall CheckTab(Vcl::Comctrls::TTabSheet* const ATab);
	void __fastcall CheckToolbar(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMControlListChange(Winapi::Messages::TMessage &Message);
	void __fastcall CreateChart(Vcl::Comctrls::TTabSheet* const ATab);
	Vcltee::Teecomma::TTeeCommander* __fastcall CreateToolBar(Vcltee::Chart::TCustomChart* const AChart);
	void __fastcall DeleteClick(System::TObject* Sender);
	void __fastcall EditClick(System::TObject* Sender);
	Vcltee::Chart::TCustomChart* __fastcall HasChart(Vcl::Comctrls::TTabSheet* const ATab);
	void __fastcall NewClick(System::TObject* Sender);
	void __fastcall Popup(System::TObject* Sender);
	void __fastcall RenameClick(System::TObject* Sender);
	void __fastcall SetToolbar(const bool Value);
	void __fastcall ToolbarClick(System::TObject* Sender);
	
protected:
	virtual void __fastcall Loaded();
	virtual void __fastcall UpdateActivePage();
	
public:
	__fastcall virtual TChartBook(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TChartBook();
	Vcltee::Chart::TCustomChart* __fastcall ActiveChart();
	Vcltee::Teecomma::TTeeCommander* __fastcall ActiveToolbar();
	Vcltee::Chart::TCustomChart* __fastcall AddChart();
	
__published:
	__property PopupMenu = {stored=false};
	__property bool ShowToolbar = {read=FToolbar, write=SetToolbar, default=0};
	__property TabPosition = {default=1};
	__property TDeleteChartEvent OnDeleteChart = {read=FOnDelete, write=FOnDelete};
	__property TNewChartEvent OnNewChart = {read=FOnNew, write=FOnNew};
public:
	/* TWinControl.CreateParented */ inline __fastcall TChartBook(HWND ParentWindow) : Vcl::Comctrls::TPageControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teechartbook */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECHARTBOOK)
using namespace Vcltee::Teechartbook;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeechartbookHPP
