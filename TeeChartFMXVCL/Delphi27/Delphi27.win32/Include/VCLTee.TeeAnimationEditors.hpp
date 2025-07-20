// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeAnimationEditors.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeanimationeditorsHPP
#define Vcltee_TeeanimationeditorsHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeanimationeditors
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAnimationEditors;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAnimationEditors : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabNumber;
	Vcl::Comctrls::TTabSheet* TabProperty;
	Vcl::Comctrls::TTabSheet* TabColor;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabStart;
	Vcl::Comctrls::TTabSheet* TabEnd;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* EStart;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* EEnd;
	Vcl::Stdctrls::TCheckBox* CBUseEnd;
	Vcl::Stdctrls::TCheckBox* CBKeepEnd;
	Vcl::Stdctrls::TCheckBox* CBUseStart;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Comctrls::TTreeView* TreeView1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Stdctrls::TListBox* LProps;
	Vcl::Stdctrls::TLabel* Label2;
	Vcltee::Tecanvas::TButtonColor* BStartColor;
	Vcltee::Tecanvas::TButtonColor* BEndColor;
	Vcltee::Tecanvas::TComboFlat* CBMethod;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TCheckBox* CBKeepEnd2;
	Vcl::Comctrls::TTabSheet* TabToggle;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall TreeView1Change(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall LPropsClick(System::TObject* Sender);
	void __fastcall EStartChange(System::TObject* Sender);
	void __fastcall EEndChange(System::TObject* Sender);
	void __fastcall CBUseEndClick(System::TObject* Sender);
	void __fastcall CBKeepEndClick(System::TObject* Sender);
	void __fastcall CBUseStartClick(System::TObject* Sender);
	void __fastcall BStartColorClick(System::TObject* Sender);
	void __fastcall BEndColorClick(System::TObject* Sender);
	void __fastcall PageControl1GetImageIndex(System::TObject* Sender, int TabIndex, int &ImageIndex);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	Vcltee::Teeanimate::TTeeAnimation* Animation;
	bool IChanging;
	void __fastcall FillProperties();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAnimationEditors(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAnimationEditors(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAnimationEditors() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAnimationEditors(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeanimationeditors */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEANIMATIONEDITORS)
using namespace Vcltee::Teeanimationeditors;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeanimationeditorsHPP
