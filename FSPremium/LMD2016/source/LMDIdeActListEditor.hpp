// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIdeActListEditor.pas' rev: 31.00 (Windows)

#ifndef LmdideactlisteditorHPP
#define LmdideactlisteditorHPP

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
#include <Vcl.ActnList.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDUnicode.hpp>
#include <LMDDsgClass.hpp>
#include <LMDDsgObjects.hpp>
#include <LMDDsgPropInsp.hpp>
#include <LMDTypes.hpp>
#include <LMDInsEditorWnds.hpp>
#include <LMDInsEditorUtils.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdideactlisteditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDActionListEditorDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDActionListEditorDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Actnlist::TActionList* UIActions;
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Comctrls::TToolButton* ToolButton1;
	Vcl::Comctrls::TToolButton* ToolButton2;
	Vcl::Comctrls::TToolButton* ToolButton3;
	Vcl::Comctrls::TToolButton* ToolButton4;
	Vcl::Comctrls::TToolButton* ToolButton5;
	Vcl::Controls::TImageList* Images;
	Vcl::Extctrls::TPanel* LeftPanel;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Extctrls::TPanel* CenterPanel;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Comctrls::TListView* CatsView;
	Vcl::Comctrls::TListView* ActsView;
	Vcl::Actnlist::TAction* actNew;
	Vcl::Actnlist::TAction* actDelete;
	Vcl::Actnlist::TAction* actUp;
	Vcl::Actnlist::TAction* actDown;
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall actNewExecute(System::TObject* Sender);
	void __fastcall CatsViewClick(System::TObject* Sender);
	void __fastcall actDeleteUpdate(System::TObject* Sender);
	void __fastcall actDeleteExecute(System::TObject* Sender);
	void __fastcall ActsViewClick(System::TObject* Sender);
	void __fastcall actUpUpdate(System::TObject* Sender);
	void __fastcall actDownUpdate(System::TObject* Sender);
	void __fastcall actUpExecute(System::TObject* Sender);
	void __fastcall actDownExecute(System::TObject* Sender);
	
private:
	Lmdinseditorwnds::TLMDEditorWindowCallbacks* FCallbacks;
	Vcl::Actnlist::TActionList* FActionList;
	void __fastcall SetFreeNotification(void);
	void __fastcall CallbacksCommand(System::TObject* Sender, Lmdinseditorwnds::TLMDEditorWndCommand ACommand);
	System::UnicodeString __fastcall GetCurrentCategory(void);
	void __fastcall UpdateView(void);
	void __fastcall UpdateCatsView(void);
	void __fastcall UpdateActsView(void);
	void __fastcall UpdateDesignerSelection(void);
	void __fastcall UpdateStayOnTop(void);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__classmethod void __fastcall OpenEditor(Lmdinseditorwnds::TLMDEditorWindowCallbacks* ACallbacks, Vcl::Actnlist::TActionList* AValue);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDActionListEditorDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDActionListEditorDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDActionListEditorDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDActionListEditorDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::ResourceString _SLMDActDlgNoCategory;
#define Lmdideactlisteditor_SLMDActDlgNoCategory System::LoadResourceString(&Lmdideactlisteditor::_SLMDActDlgNoCategory)
}	/* namespace Lmdideactlisteditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIDEACTLISTEDITOR)
using namespace Lmdideactlisteditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdideactlisteditorHPP
