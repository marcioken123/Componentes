// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ac3rdPartyEditor.pas' rev: 27.00 (Windows)

#ifndef Ac3rdpartyeditorHPP
#define Ac3rdpartyeditorHPP

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
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <sBitBtn.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <sListView.hpp>	// Pascal unit
#include <sSkinManager.hpp>	// Pascal unit
#include <sSkinProvider.hpp>	// Pascal unit
#include <sSpeedButton.hpp>	// Pascal unit
#include <sPanel.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sCheckListBox.hpp>	// Pascal unit
#include <sCheckBox.hpp>	// Pascal unit
#include <sLabel.hpp>	// Pascal unit
#include <sListBox.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ac3rdpartyeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TForm3rdPartyEditor;
class PASCALIMPLEMENTATION TForm3rdPartyEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Slistview::TsListView* sListView1;
	Sbitbtn::TsBitBtn* sBitBtn1;
	Sspeedbutton::TsSpeedButton* sBitBtn2;
	Sspeedbutton::TsSpeedButton* sBitBtn3;
	Sskinprovider::TsSkinProvider* sSkinProvider1;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Menus::TMenuItem* Addnew1;
	Vcl::Menus::TMenuItem* Delete1;
	Vcl::Menus::TMenuItem* Defaultsettings1;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* Exit1;
	Sspeedbutton::TsSpeedButton* sSpeedButton1;
	Sspeedbutton::TsSpeedButton* sSpeedButton4;
	Sspeedbutton::TsSpeedButton* sSpeedButton5;
	Vcl::Dialogs::TSaveDialog* SaveDialog1;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Sspeedbutton::TsSpeedButton* sSpeedButton6;
	Spanel::TsPanel* sPanel1;
	Slistbox::TsListBox* sListBox1;
	Spanel::TsPanel* sPanel2;
	Schecklistbox::TsCheckListBox* sListBox2;
	Vcl::Menus::TMenuItem* Edit1;
	Scheckbox::TsCheckBox* sCheckBox1;
	Sspeedbutton::TsSpeedButton* sSpeedButton2;
	void __fastcall sBitBtn2Click(System::TObject* Sender);
	void __fastcall sBitBtn1Click(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall sBitBtn3Click(System::TObject* Sender);
	void __fastcall sSpeedButton1Click(System::TObject* Sender);
	void __fastcall sListView1Change(System::TObject* Sender, Vcl::Comctrls::TListItem* Item, Vcl::Comctrls::TItemChange Change);
	void __fastcall sListBox1Click(System::TObject* Sender);
	void __fastcall sSpeedButton2Click(System::TObject* Sender);
	void __fastcall sListView1ColumnClick(System::TObject* Sender, Vcl::Comctrls::TListColumn* Column);
	void __fastcall sSpeedButton4Click(System::TObject* Sender);
	void __fastcall sSpeedButton5Click(System::TObject* Sender);
	void __fastcall sSpeedButton6Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Edit1Click(System::TObject* Sender);
	void __fastcall sCheckBox1Click(System::TObject* Sender);
	void __fastcall sListView1DblClick(System::TObject* Sender);
	
public:
	Sskinmanager::TsSkinManager* SM;
	void __fastcall Populate(bool ControlRepaint = true);
	void __fastcall SelectCtrls(int TypeIndex);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TForm3rdPartyEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TForm3rdPartyEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TForm3rdPartyEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TForm3rdPartyEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


typedef System::StaticArray<System::UnicodeString, 14> Ac3rdpartyeditor__2;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TForm3rdPartyEditor* Form3rdPartyEditor;
extern DELPHI_PACKAGE Ac3rdpartyeditor__2 acCtrlsArray;
}	/* namespace Ac3rdpartyeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_AC3RDPARTYEDITOR)
using namespace Ac3rdpartyeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ac3rdpartyeditorHPP
