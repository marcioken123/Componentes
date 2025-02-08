// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDActnListEditor.pas' rev: 31.00 (Windows)

#ifndef PlmdactnlisteditorHPP
#define PlmdactnlisteditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <LMDActnList.hpp>
#include <LMDUtils.hpp>
#include <LMDStdActns.hpp>
#include <LMDTypes.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.StdActns.hpp>
#include <DesignEditors.hpp>
#include <DesignWindows.hpp>
#include <DsnConst.hpp>
#include <DesignIntf.hpp>
#include <System.Actions.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdactnlisteditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmActionListEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmActionListEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Comctrls::TToolButton* ToolButton1;
	Vcl::Comctrls::TToolButton* ToolButton2;
	Vcl::Actnlist::TActionList* ActionList1;
	Vcl::Menus::TPopupMenu* mnuStd;
	Vcl::Actnlist::TAction* actNewAction;
	Vcl::Actnlist::TAction* actNewStandardAction;
	Vcl::Menus::TMenuItem* NewAction1;
	Vcl::Menus::TMenuItem* Newstandardaction1;
	Vcl::Comctrls::TToolButton* ToolButton3;
	Vcl::Comctrls::TToolButton* ToolButton4;
	Vcl::Comctrls::TToolButton* ToolButton5;
	Vcl::Stdctrls::TListBox* lstCategory;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Stdctrls::TListBox* lstAction;
	Vcl::Controls::TImageList* ImageList1;
	Vcl::Menus::TPopupMenu* mnuActions;
	Vcl::Actnlist::TAction* actMoveUp;
	Vcl::Actnlist::TAction* actMoveDown;
	Vcl::Actnlist::TAction* actDelete;
	Vcl::Menus::TPopupMenu* mnuToolbar;
	Vcl::Actnlist::TAction* actTextLabel;
	Vcl::Menus::TMenuItem* extLabels1;
	Vcl::Extctrls::TTimer* tmrUpdate;
	Vcl::Menus::TMenuItem* NewAction2;
	Vcl::Menus::TMenuItem* Newstandardaction2;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* MoveUp1;
	Vcl::Menus::TMenuItem* MoveDown1;
	Vcl::Menus::TMenuItem* N2;
	Vcl::Actnlist::TAction* actSwitchToolbar;
	Vcl::Menus::TMenuItem* N3;
	Vcl::Menus::TMenuItem* actSwitchToolbar1;
	Vcl::Stdactns::TEditCut* actEditCut;
	Vcl::Stdactns::TEditCopy* actEditCopy;
	Vcl::Stdactns::TEditPaste* actEditPaste;
	Vcl::Menus::TMenuItem* Copy1;
	Vcl::Menus::TMenuItem* Cut1;
	Vcl::Menus::TMenuItem* Paste1;
	Vcl::Menus::TMenuItem* Delete1;
	void __fastcall actNewStandardActionExecute(System::TObject* Sender);
	void __fastcall actNewActionExecute(System::TObject* Sender);
	void __fastcall lstCategoryMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall lstCategoryKeyUp(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall lstActionMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall lstActionKeyUp(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall actTextLabelExecute(System::TObject* Sender);
	void __fastcall actMoveUpExecute(System::TObject* Sender);
	void __fastcall actMoveDownExecute(System::TObject* Sender);
	void __fastcall actDeleteExecute(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall lstCategoryClick(System::TObject* Sender);
	void __fastcall lstActionClick(System::TObject* Sender);
	void __fastcall tmrUpdateTimer(System::TObject* Sender);
	void __fastcall actSwitchToolbarExecute(System::TObject* Sender);
	void __fastcall actEditCutExecute(System::TObject* Sender);
	void __fastcall actEditCopyExecute(System::TObject* Sender);
	void __fastcall actEditPasteExecute(System::TObject* Sender);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
private:
	void __fastcall ActionEnumarator(const System::UnicodeString Category, System::Classes::TBasicActionClass ActionClass, void * Info);
	void __fastcall NotifyCategoryChange(void);
	void __fastcall SelectAction(void);
	void __fastcall AddNewAction(System::Classes::TBasicActionClass AClass, const System::UnicodeString ACategory);
	System::UnicodeString __fastcall UniqueActionName(System::UnicodeString LName);
	void __fastcall UpdateActionsState(void);
	
public:
	Lmdactnlist::TLMDActionList* FActionList;
	Designintf::_di_IDesigner FDesigner;
	void __fastcall UpdateList(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmActionListEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmActionListEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmActionListEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmActionListEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrmActionListEditor* frmActionListEditor;
}	/* namespace Plmdactnlisteditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDACTNLISTEDITOR)
using namespace Plmdactnlisteditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdactnlisteditorHPP
