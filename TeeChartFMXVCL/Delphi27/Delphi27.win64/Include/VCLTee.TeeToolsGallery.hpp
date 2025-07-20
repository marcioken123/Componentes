// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeToolsGallery.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeetoolsgalleryHPP
#define Vcltee_TeetoolsgalleryHPP

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
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teetoolsgallery
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeToolsGallery;
//-- type declarations -------------------------------------------------------
typedef System::TObject* __fastcall (*TToolsGalleryHook)(TTeeToolsGallery* const Gallery);

class PASCALIMPLEMENTATION TTeeToolsGallery : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* P1;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* BOk;
	Vcl::Stdctrls::TButton* BCan;
	Vcl::Comctrls::TTabControl* TabControl1;
	Vcl::Stdctrls::TListBox* LBTool;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TMemo* MemoDesc;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Extctrls::TPanel* PanelDemos;
	Vcl::Extctrls::TSplitter* Splitter2;
	Vcl::Stdctrls::TCheckBox* CBView3D;
	Vcl::Stdctrls::TLabel* LabelClass;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Stdctrls::TButton* BEditTool;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall LBToolDblClick(System::TObject* Sender);
	void __fastcall LBToolDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall LBToolClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall BEditToolClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Vcltee::Teengine::TTeeCustomToolClass __fastcall ToolAtIndex(int AIndex);
	void __fastcall View3DClick(System::TObject* Sender);
	
protected:
	bool AddTabs;
	bool AllowEditButton;
	TToolsGalleryHook TheGalleryHook;
	Vcltee::Chart::TTeeToolTypes* TypesToShow;
	System::TObject* IDemos;
	void __fastcall AddTool(const System::UnicodeString ADesc, System::TObject* const ATool);
	virtual bool __fastcall FilterTool(int Index);
	virtual void __fastcall FillTools();
	Vcltee::Chart::TCustomChart* __fastcall PreviewChart();
	
public:
	Vcltee::Teengine::TTeeCustomToolClass __fastcall SelectedTool();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTeeToolsGallery(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTeeToolsGallery(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTeeToolsGallery() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTeeToolsGallery(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TToolsGalleryHook ToolsGalleryHook;
extern DELPHI_PACKAGE void __fastcall TeeDrawTool(Vcl::Stdctrls::TListBox* const AList, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State, Vcltee::Teengine::TTeeCustomTool* const ATool);
}	/* namespace Teetoolsgallery */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETOOLSGALLERY)
using namespace Vcltee::Teetoolsgallery;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeetoolsgalleryHPP
