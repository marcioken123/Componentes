// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSeriesDesign.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeseriesdesignHPP
#define Vcltee_TeeseriesdesignHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Dialogs.hpp>
#include <DesignIntf.hpp>
#include <DesignWindows.hpp>
#include <ToolWnds.hpp>
#include <VCLTee.TeeLisB.hpp>
#include <VCLTee.Chart.hpp>
#include <Vcl.ToolWin.hpp>
#include <VCLTee.TeeProCo.hpp>
#include <VCLTee.TeEngine.hpp>
#include <TeeChartReg.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeseriesdesign
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeDesignerList;
class DELPHICLASS TSeriesEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeDesignerList : public Designintf::TDesignerSelections
{
	typedef Designintf::TDesignerSelections inherited;
	
public:
	/* TDesignerSelections.Create */ inline __fastcall virtual TTeeDesignerList() : Designintf::TDesignerSelections() { }
	/* TDesignerSelections.Copy */ inline __fastcall TTeeDesignerList(const Designintf::_di_IDesignerSelections Selections) : Designintf::TDesignerSelections(Selections) { }
	/* TDesignerSelections.Destroy */ inline __fastcall virtual ~TTeeDesignerList() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TSeriesEditor : public Designwindows::TDesignWindow
{
	typedef Designwindows::TDesignWindow inherited;
	
__published:
	Vcl::Menus::TPopupMenu* LocalMenu;
	Vcl::Menus::TMenuItem* AddItem;
	Vcl::Menus::TMenuItem* DeleteItem;
	Vcl::Menus::TMenuItem* SelectAllItem;
	Vcl::Menus::TMenuItem* CloneItem;
	Vcl::Menus::TMenuItem* Change1;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* Edit1;
	Vcl::Menus::TMenuItem* Title1;
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Comctrls::TToolButton* SBAdd;
	Vcl::Comctrls::TToolButton* SBDelete;
	Vcl::Comctrls::TToolButton* ToolButton3;
	Vcl::Comctrls::TToolButton* TBMoveUp;
	Vcl::Comctrls::TToolButton* TBMoveDown;
	Vcl::Comctrls::TToolButton* ToolButton6;
	Vcl::Comctrls::TToolButton* SBEdit;
	Vcl::Controls::TImageList* ImageList1;
	Vcl::Menus::TMenuItem* N2;
	Vcl::Menus::TMenuItem* MoveUp1;
	Vcl::Menus::TMenuItem* MoveDown1;
	Vcltee::Teelisb::TChartListBox* ChartListBox1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall AListBoxKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall SelectAllItemClick(System::TObject* Sender);
	void __fastcall LocalMenuPopup(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CloneItemClick(System::TObject* Sender);
	void __fastcall Change1Click(System::TObject* Sender);
	void __fastcall ChartListBox1Click(System::TObject* Sender);
	void __fastcall ChartListBox1DblClickSeries(Vcltee::Teelisb::TChartListBox* Sender, int Index);
	void __fastcall Title1Click(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall SBAddClick(System::TObject* Sender);
	void __fastcall SBDeleteClick(System::TObject* Sender);
	void __fastcall SBEditClick(System::TObject* Sender);
	void __fastcall TBMoveUpClick(System::TObject* Sender);
	void __fastcall TBMoveDownClick(System::TObject* Sender);
	
private:
	Teechartreg::TTeeEditSeriesProc FEditSeriesProc;
	void __fastcall CheckChangedSeries(System::Classes::TPersistent* AItem);
	void __fastcall CheckDelete();
	void __fastcall EnableButtons();
	void __fastcall UpdateDisplay();
	void __fastcall UpdateCaption();
	void __fastcall UpdateSelection();
	
protected:
	DYNAMIC void __fastcall Activated();
	virtual System::UnicodeString __fastcall UniqueName(System::Classes::TComponent* Component);
	
public:
	virtual void __fastcall ItemDeleted(const Designintf::_di_IDesigner ADesigner, System::Classes::TPersistent* AItem);
	virtual void __fastcall ItemInserted(const Designintf::_di_IDesigner ADesigner, System::Classes::TPersistent* AItem);
	virtual void __fastcall SelectionChanged(const Designintf::_di_IDesigner ADesigner, const Designintf::_di_IDesignerSelections ASelection);
public:
	/* TDesignWindow.Create */ inline __fastcall virtual TSeriesEditor(System::Classes::TComponent* AOwner) : Designwindows::TDesignWindow(AOwner) { }
	/* TDesignWindow.Destroy */ inline __fastcall virtual ~TSeriesEditor() { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Designwindows::TDesignWindow(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSeriesEditor(HWND ParentWindow) : Designwindows::TDesignWindow(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall TeeShowSeriesEditor(Designintf::_di_IDesigner ADesigner, Vcltee::Teengine::TCustomSeriesList* AList, Teechartreg::TTeeEditSeriesProc EditSeriesProc, Vcltee::Teengine::TSeriesGroup* AGroup = (Vcltee::Teengine::TSeriesGroup*)(0x0));
}	/* namespace Teeseriesdesign */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESERIESDESIGN)
using namespace Vcltee::Teeseriesdesign;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeseriesdesignHPP
