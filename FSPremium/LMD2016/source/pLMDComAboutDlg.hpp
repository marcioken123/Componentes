// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDComAboutDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdcomaboutdlgHPP
#define PlmdcomaboutdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.CheckLst.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <pLMDURLLabel.hpp>
#include <pLMDCst.hpp>
#include <pLMDCommon.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdcomaboutdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDAboutDlg;
class DELPHICLASS TLMDAboutProperty;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDAboutDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* ok;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TImage* Image1;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TLabel* lblversion;
	Vcl::Stdctrls::TLabel* lblversionExt;
	Vcl::Stdctrls::TLabel* lbldesc;
	Vcl::Stdctrls::TLabel* lblcopyright;
	Vcl::Extctrls::TBevel* bv;
	Plmdurllabel::TLMDURLLabel* lblwebsite;
	Vcl::Stdctrls::TLabel* lblsysinfo;
	Vcl::Stdctrls::TButton* btnReg;
	Vcl::Stdctrls::TLabel* lblquestion;
	Plmdurllabel::TLMDURLLabel* lblsupport;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Extctrls::TBevel* Bevel2;
	Vcl::Stdctrls::TButton* Button2;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall btnRegClick(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	
private:
	System::UnicodeString FApp;
	System::UnicodeString FClipText;
	System::UnicodeString FPack;
	Lmdtypes::TLMDPackageID FPackageID;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDAboutDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDAboutDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDAboutDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDAboutDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDAboutProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TLMDAboutProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TLMDAboutProperty(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdcomaboutdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCOMABOUTDLG)
using namespace Plmdcomaboutdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdcomaboutdlgHPP
