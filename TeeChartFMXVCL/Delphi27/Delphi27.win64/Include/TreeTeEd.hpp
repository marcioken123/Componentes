// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeTeEd.pas' rev: 34.00 (Windows)

#ifndef TreeteedHPP
#define TreeteedHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <TeeTree.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeEdiFont.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Treeteed
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFormTeeText;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TFormTeeText : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* Edit2;
	Vcl::Comctrls::TUpDown* UpDown2;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TLabel* Label2;
	Vcltee::Tecanvas::TComboFlat* CBHorizAlign;
	Vcl::Stdctrls::TLabel* Label7;
	Vcltee::Tecanvas::TComboFlat* CBVertAlign;
	Vcl::Stdctrls::TEdit* Edit3;
	Vcl::Comctrls::TUpDown* UpDown3;
	Vcl::Stdctrls::TEdit* Edit4;
	Vcl::Comctrls::TUpDown* UpDown4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TEdit* Edit7;
	Vcl::Comctrls::TUpDown* UpDown7;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TMemo* Memo2;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Extctrls::TShape* Shape5;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TCheckBox* CBClip;
	Vcl::Comctrls::TTabSheet* TabFont;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Stdctrls::TCheckBox* CBVisible;
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall Memo2Change(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBHorizAlignChange(System::TObject* Sender);
	void __fastcall Shape5MouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall Edit2Change(System::TObject* Sender);
	void __fastcall CBClipClick(System::TObject* Sender);
	void __fastcall Edit3Change(System::TObject* Sender);
	void __fastcall Edit4Change(System::TObject* Sender);
	void __fastcall CBVertAlignChange(System::TObject* Sender);
	void __fastcall Edit7Change(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall CBVisibleClick(System::TObject* Sender);
	
private:
	bool Changing;
	bool IsConnection;
	Vcltee::Teeedifont::TTeeFontEditor* IFontEditor;
	
public:
	Teetree::TCustomTree* Tree1;
	Teetree::TTreeConnection* Connection1;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFormTeeText(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFormTeeText(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFormTeeText() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFormTeeText(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall TreeEditText(System::Classes::TComponent* AOwner, Teetree::TCustomTreeElement* AElement);
}	/* namespace Treeteed */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TREETEED)
using namespace Treeteed;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreeteedHPP
