﻿// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sHintDesigner.pas' rev: 27.00 (Windows)

#ifndef ShintdesignerHPP
#define ShintdesignerHPP

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
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <Vcl.ExtDlgs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <sHintManager.hpp>	// Pascal unit
#include <sEdit.hpp>	// Pascal unit
#include <sBitBtn.hpp>	// Pascal unit
#include <sSpeedButton.hpp>	// Pascal unit
#include <sPanel.hpp>	// Pascal unit
#include <sCheckBox.hpp>	// Pascal unit
#include <sGroupBox.hpp>	// Pascal unit
#include <sTrackBar.hpp>	// Pascal unit
#include <sComboBox.hpp>	// Pascal unit
#include <sLabel.hpp>	// Pascal unit
#include <sSkinProvider.hpp>	// Pascal unit
#include <sColorSelect.hpp>	// Pascal unit
#include <sDialogs.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Shintdesigner
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS THintDesigner;
class PASCALIMPLEMENTATION THintDesigner : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Slabel::TsLabel* Label1;
	Slabel::TsLabel* Label3;
	Slabel::TsLabel* Label5;
	Slabel::TsLabel* Label6;
	Slabel::TsLabel* Label7;
	Slabel::TsLabel* Label8;
	Slabel::TsLabel* Label9;
	Slabel::TsLabel* Label10;
	Scombobox::TsComboBox* sComboBox4;
	Scombobox::TsComboBox* sComboBox1;
	Strackbar::TsTrackBar* sTrackBar1;
	Strackbar::TsTrackBar* sTrackBar2;
	Strackbar::TsTrackBar* sTrackBar3;
	Strackbar::TsTrackBar* sTrackBar4;
	Strackbar::TsTrackBar* sTrackBar5;
	Strackbar::TsTrackBar* sTrackBar21;
	Sgroupbox::TsGroupBox* GroupBox1;
	Slabel::TsLabel* Label12;
	Slabel::TsLabel* Label13;
	Slabel::TsLabel* Label14;
	Scheckbox::TsCheckBox* sCheckBox1;
	Strackbar::TsTrackBar* sTrackBar9;
	Strackbar::TsTrackBar* sTrackBar10;
	Strackbar::TsTrackBar* sTrackBar11;
	Sgroupbox::TsGroupBox* GroupBox2;
	Sgroupbox::TsGroupBox* GroupBox3;
	Sbitbtn::TsBitBtn* BitBtn1;
	Spanel::TsPanel* Panel1;
	Sedit::TsEdit* sSpinEdit2;
	Vcl::Dialogs::TFontDialog* FontDialog1;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Menus::TMenuItem* Gotohomesite1;
	Vcl::Menus::TMenuItem* Feedback1;
	Strackbar::TsTrackBar* sTrackBar12;
	Slabel::TsLabel* Label17;
	Slabel::TsLabel* Label2;
	Spanel::TsPanel* Panel4;
	Vcl::Extctrls::TPaintBox* PaintBox1;
	Strackbar::TsTrackBar* TrackBar1;
	Slabel::TsLabel* Label11;
	Sbitbtn::TsBitBtn* BitBtn2;
	Sbitbtn::TsBitBtn* BitBtn3;
	Vcl::Extdlgs::TOpenPictureDialog* OpenPictureDialog1;
	Strackbar::TsTrackBar* TrackBar2;
	Slabel::TsLabel* Label15;
	Vcl::Extctrls::TPaintBox* PaintBox2;
	Vcl::Dialogs::TSaveDialog* SaveDialog1;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Sskinprovider::TsSkinProvider* sSkinProvider1;
	Scolorselect::TsColorSelect* sColorSelect2;
	Scolorselect::TsColorSelect* sColorSelect3;
	Scolorselect::TsColorSelect* sColorSelect4;
	Sbitbtn::TsBitBtn* sBitBtn1;
	Sbitbtn::TsBitBtn* sBitBtn2;
	void __fastcall sComboBox4Change(System::TObject* Sender);
	void __fastcall sComboBox1Change(System::TObject* Sender);
	void __fastcall sTrackBar1Change(System::TObject* Sender);
	void __fastcall sTrackBar2Change(System::TObject* Sender);
	void __fastcall sTrackBar3Change(System::TObject* Sender);
	void __fastcall sTrackBar4Change(System::TObject* Sender);
	void __fastcall sTrackBar5Change(System::TObject* Sender);
	void __fastcall sTrackBar21Change(System::TObject* Sender);
	void __fastcall sSpinEdit2Change(System::TObject* Sender);
	void __fastcall sCheckBox1Click(System::TObject* Sender);
	void __fastcall sTrackBar9Change(System::TObject* Sender);
	void __fastcall sTrackBar10Change(System::TObject* Sender);
	void __fastcall sTrackBar11Change(System::TObject* Sender);
	void __fastcall sTrackBar12Change(System::TObject* Sender);
	void __fastcall BitBtn1Click(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall PaintBox1Paint(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall TrackBar1Change(System::TObject* Sender);
	void __fastcall TrackBar2Change(System::TObject* Sender);
	void __fastcall PaintBox2Paint(System::TObject* Sender);
	void __fastcall PaintBox2MouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall BitBtn3Click(System::TObject* Sender);
	void __fastcall BitBtn2Click(System::TObject* Sender);
	void __fastcall sColorSelect2Change(System::TObject* Sender);
	void __fastcall sColorSelect3Change(System::TObject* Sender);
	void __fastcall sColorSelect4Change(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall sBitBtn1Click(System::TObject* Sender);
	void __fastcall sBitBtn2Click(System::TObject* Sender);
	void __fastcall OpenDialog1SelectionChange(System::TObject* Sender);
	
public:
	Shintmanager::TsHintManager* sHintManager1;
	Shintmanager::TsCustomHintWindow* PreviewWnd;
	void __fastcall SetPanelColor(Vcl::Extctrls::TPanel* Panel, System::Uitypes::TColor c);
	void __fastcall InitControls(Shintmanager::TsHintManager* Manager, System::TObject* Sender);
	void __fastcall LoadPreserved(int i);
	void __fastcall SetcustomStyle(void);
	void __fastcall PrepareMainBmp(void);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	void __fastcall InitLngCaptions(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual THintDesigner(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual THintDesigner(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~THintDesigner(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THintDesigner(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE THintDesigner* HintDesigner;
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* MainBmp;
extern DELPHI_PACKAGE void __fastcall CreateEditorForm(void);
extern DELPHI_PACKAGE void __fastcall OpenDesigner(void);
extern DELPHI_PACKAGE void __fastcall KillForm(void);
}	/* namespace Shintdesigner */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SHINTDESIGNER)
using namespace Shintdesigner;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ShintdesignerHPP
