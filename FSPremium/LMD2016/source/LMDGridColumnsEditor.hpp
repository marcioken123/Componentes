// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGridColumnsEditor.pas' rev: 31.00 (Windows)

#ifndef LmdgridcolumnseditorHPP
#define LmdgridcolumnseditorHPP

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
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ToolWin.hpp>
#include <System.Contnrs.hpp>
#include <DesignWindows.hpp>
#include <DesignIntf.hpp>
#include <LMDGrid.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdgridcolumnseditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDGridColumnEditForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDGridColumnEditForm : public Designwindows::TDesignWindow
{
	typedef Designwindows::TDesignWindow inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Comctrls::TListView* ColumnList;
	Vcl::Comctrls::TToolBar* ToolBar;
	Vcl::Controls::TImageList* DefImages;
	Vcl::Controls::TImageList* ToolsImages;
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Comctrls::TToolButton* btnDel;
	Vcl::Comctrls::TToolButton* btnClear;
	Vcl::Comctrls::TToolButton* ToolButton3;
	Vcl::Comctrls::TToolButton* btnUp;
	Vcl::Comctrls::TToolButton* btnDown;
	Vcl::Comctrls::TToolButton* ToolButton1;
	Vcl::Comctrls::TToolButton* btnTop;
	Vcl::Comctrls::TToolButton* ToolButton2;
	Vcl::Comctrls::TToolButton* btnAddAll;
	Vcl::Controls::TImageList* Images;
	void __fastcall btnDelClick(System::TObject* Sender);
	void __fastcall btnClearClick(System::TObject* Sender);
	void __fastcall ColumnListKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall btnTopClick(System::TObject* Sender);
	void __fastcall ColumnListSelectItem(System::TObject* Sender, Vcl::Comctrls::TListItem* Item, bool Selected);
	void __fastcall btnUpClick(System::TObject* Sender);
	void __fastcall btnDownClick(System::TObject* Sender);
	void __fastcall btnAddAllClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	Designintf::_di_IDesigner FDesigner;
	bool FClosing;
	int FUpdateCnt;
	Lmdgrid::TLMDCustomGrid* FGrid;
	void __fastcall CheckColDelete(bool ACheckAll);
	void __fastcall CheckColAdd(void);
	void __fastcall NameSetProc(Lmdgrid::TLMDGridColumn* ACol);
	void __fastcall CloseEditor(void);
	void __fastcall OnAddColClick(System::TObject* ASender);
	int __fastcall GetColClassIdx(System::TClass AColClass);
	void __fastcall RemoveCurrentCol(void);
	void __fastcall ReloadAll(bool ASelToDesigner);
	void __fastcall MoveCurrentUpDown(bool AUp);
	void __fastcall UpdateStatus(void);
	
protected:
	DYNAMIC void __fastcall Activated(void);
	
public:
	__fastcall TLMDGridColumnEditForm(Lmdgrid::TLMDCustomGrid* AGrid, const Designintf::_di_IDesigner ADesigner);
	virtual void __fastcall DesignerClosed(const Designintf::_di_IDesigner ADesigner, bool AGoingDormant);
	virtual void __fastcall ItemDeleted(const Designintf::_di_IDesigner ADesigner, System::Classes::TPersistent* AItem);
	virtual void __fastcall ItemsModified(const Designintf::_di_IDesigner ADesigner);
	virtual void __fastcall SelectionChanged(const Designintf::_di_IDesigner ADesigner, const Designintf::_di_IDesignerSelections ASelection);
	__property Lmdgrid::TLMDCustomGrid* Grid = {read=FGrid};
public:
	/* TDesignWindow.Destroy */ inline __fastcall virtual ~TLMDGridColumnEditForm(void) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDGridColumnEditForm(System::Classes::TComponent* AOwner, int Dummy) : Designwindows::TDesignWindow(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDGridColumnEditForm(HWND ParentWindow) : Designwindows::TDesignWindow(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDGridShowColumnsDialog(Lmdgrid::TLMDCustomGrid* AGrid, const Designintf::_di_IDesigner ADesigner);
}	/* namespace Lmdgridcolumnseditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGRIDCOLUMNSEDITOR)
using namespace Lmdgridcolumnseditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdgridcolumnseditorHPP
