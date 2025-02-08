// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwrichtb.pas' rev: 6.00

#ifndef wwrichtbHPP
#define wwrichtbHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Wwintl.hpp>	// Pascal unit
#include <RichEdit.hpp>	// Pascal unit
#include <wwSystem.hpp>	// Pascal unit
#include <Wwstr.hpp>	// Pascal unit
#include <wwriched.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwrichtb
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwRichTabDialog;
class PASCALIMPLEMENTATION TwwRichTabDialog : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TButton* OKButton;
	Stdctrls::TGroupBox* GroupBox1;
	Stdctrls::TEdit* Edit1;
	Stdctrls::TListBox* ListBox1;
	Stdctrls::TButton* Button1;
	Stdctrls::TButton* Button2;
	Stdctrls::TButton* Button3;
	Stdctrls::TButton* Button4;
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall SetButtonClick(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall Edit1Enter(System::TObject* Sender);
	void __fastcall Edit1Exit(System::TObject* Sender);
	void __fastcall Edit1KeyPress(System::TObject* Sender, char &Key);
	void __fastcall OKButtonClick(System::TObject* Sender);
	
private:
	Wwriched::TwwCustomRichEdit* richedit;
	void __fastcall ApplyIntl(void);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TwwRichTabDialog(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwRichTabDialog(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TwwRichTabDialog(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwRichTabDialog(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwrichtb)
extern PACKAGE TwwRichTabDialog* wwRichTabDialog;
extern PACKAGE bool __fastcall wwRichTabDlg(Wwriched::TwwCustomRichEdit* richedit1);

}	/* namespace Wwrichtb */
using namespace Wwrichtb;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwrichtb
