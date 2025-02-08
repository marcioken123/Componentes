// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CustomiseEditDialog.pas' rev: 31.00 (Windows)

#ifndef CustomiseeditdialogHPP
#define CustomiseeditdialogHPP

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
#include <CustomiseDialog.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.ExtDlgs.hpp>
#include <JSDialog.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ComCtrls.hpp>
#include <JSTypes.hpp>
#include <JSEditDialog.hpp>
#include <JSDialogs.hpp>
#include <JSEditDialogs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Customiseeditdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmCustomiseEditDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmCustomiseEditDialog : public Customisedialog::TfrmCustomiseDialog
{
	typedef Customisedialog::TfrmCustomiseDialog inherited;
	
__published:
	Jseditdialog::TJSEditDialog* JSEditDialog1;
	Vcl::Comctrls::TTabSheet* tsEdit;
	Vcl::Extctrls::TRadioGroup* rgEditPropertiesCaptionPosition;
	Vcl::Extctrls::TRadioGroup* rgEditPropertiesCoverageType;
	Vcl::Extctrls::TRadioGroup* rgEditPropertiesEditType;
	Vcl::Stdctrls::TEdit* eEditPropertiesCoverage;
	Vcl::Stdctrls::TEdit* eEditPropertiesCaption;
	Vcl::Stdctrls::TCheckBox* cbEditPropertiesAllowDoubleClickToClose;
	Vcl::Stdctrls::TEdit* eEditPropertiesHeight;
	Vcl::Stdctrls::TEdit* eEditPropertiesValue;
	Vcl::Stdctrls::TLabel* Label46;
	Vcl::Stdctrls::TLabel* Label47;
	Vcl::Stdctrls::TLabel* Label48;
	Vcl::Stdctrls::TLabel* Label49;
	Vcl::Stdctrls::TGroupBox* gbEditPropertiesItems;
	Vcl::Stdctrls::TListBox* lbEditPropertiesItems;
	Vcl::Stdctrls::TButton* bEditPropertiesItemsAdd;
	Vcl::Stdctrls::TButton* bEditPropertiesItemsRemove;
	Vcl::Stdctrls::TButton* bEditPropertiesItemsClear;
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall bEditPropertiesItemsClearClick(System::TObject* Sender);
	void __fastcall bEditPropertiesItemsRemoveClick(System::TObject* Sender);
	void __fastcall bEditPropertiesItemsAddClick(System::TObject* Sender);
	
private:
	Jseditdialog::TJSEditDialog* FTempDialog;
	
protected:
	virtual void __fastcall CreateTempDialog(void);
	virtual void __fastcall DestroyTempDialog(void);
	virtual Jsdialog::TJSDialog* __fastcall GetTempDialog(void);
	virtual void __fastcall LoadDialogValues(void);
	virtual void __fastcall SaveDialogValues(Jsdialog::TJSDialog* ADialog);
public:
	/* TfrmCustomiseDialog.Create */ inline __fastcall virtual TfrmCustomiseEditDialog(System::Classes::TComponent* AOwner) : Customisedialog::TfrmCustomiseDialog(AOwner) { }
	/* TfrmCustomiseDialog.Destroy */ inline __fastcall virtual ~TfrmCustomiseEditDialog(void) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmCustomiseEditDialog(System::Classes::TComponent* AOwner, int Dummy) : Customisedialog::TfrmCustomiseDialog(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmCustomiseEditDialog(HWND ParentWindow) : Customisedialog::TfrmCustomiseDialog(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrmCustomiseEditDialog* frmCustomiseEditDialog;
}	/* namespace Customiseeditdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_CUSTOMISEEDITDIALOG)
using namespace Customiseeditdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CustomiseeditdialogHPP
