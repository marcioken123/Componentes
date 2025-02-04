// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sInternalSkins.pas' rev: 27.00 (Windows)

#ifndef SinternalskinsHPP
#define SinternalskinsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.FileCtrl.hpp>	// Pascal unit
#include <Vcl.ActnList.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <sSkinManager.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit
#include <sSkinProvider.hpp>	// Pascal unit
#include <sPanel.hpp>	// Pascal unit
#include <sButton.hpp>	// Pascal unit
#include <sListBox.hpp>	// Pascal unit
#include <sLabel.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sinternalskins
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFormInternalSkins;
class PASCALIMPLEMENTATION TFormInternalSkins : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Actnlist::TActionList* ActionList1;
	Vcl::Actnlist::TAction* ActionAddNew;
	Vcl::Actnlist::TAction* ActionDelete;
	Vcl::Actnlist::TAction* ActionRename;
	Vcl::Actnlist::TAction* ActionClose;
	Sskinprovider::TsSkinProvider* sSkinProvider1;
	Vcl::Actnlist::TAction* ActionClear;
	Vcl::Actnlist::TAction* ActionExtract;
	Vcl::Actnlist::TAction* ActionUpdateAll;
	Spanel::TsPanel* sPanel2;
	Slistbox::TsListBox* ListBox1;
	Spanel::TsPanel* sPanel3;
	Slabel::TsLabel* sLabel1;
	Slabel::TsLabel* sLabel2;
	Spanel::TsPanel* sPanel1;
	Spanel::TsPanel* sPanel4;
	Sbutton::TsButton* sButton2;
	Sbutton::TsButton* sButton3;
	Sbutton::TsButton* sButton4;
	Sbutton::TsButton* sButton1;
	Sbutton::TsButton* sButton5;
	Sbutton::TsButton* sButton6;
	Spanel::TsPanel* sPanel5;
	Sbutton::TsButton* sBitBtn1;
	void __fastcall ActionAddNewExecute(System::TObject* Sender);
	void __fastcall ActionCloseExecute(System::TObject* Sender);
	void __fastcall ActionRenameExecute(System::TObject* Sender);
	void __fastcall ActionDeleteExecute(System::TObject* Sender);
	void __fastcall ListBox1Click(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ActionExtractExecute(System::TObject* Sender);
	void __fastcall ActionClearExecute(System::TObject* Sender);
	void __fastcall ActionUpdateAllExecute(System::TObject* Sender);
	
public:
	System::UnicodeString NewName;
	System::UnicodeString NewDir;
	Sskinmanager::TsSkinManager* SkinManager;
	void __fastcall AddNewSkin(void);
	void __fastcall UpdateMyActions(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFormInternalSkins(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFormInternalSkins(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFormInternalSkins(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFormInternalSkins(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TFormInternalSkins* FormInternalSkins;
}	/* namespace Sinternalskins */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SINTERNALSKINS)
using namespace Sinternalskins;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SinternalskinsHPP
