// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolAboutUnit.pas' rev: 6.00

#ifndef CoolAboutUnitHPP
#define CoolAboutUnitHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ShellAPI.hpp>	// Pascal unit
#include <CoolCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Coolaboutunit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFormAbout;
class PASCALIMPLEMENTATION TFormAbout : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TImage* Image;
	Coolctrls::TCoolLabel* LabelVersion;
	Coolctrls::TCoolLabel* LabelCopyright;
	Coolctrls::TCoolLabel* LabelName;
	Coolctrls::TCoolLabel* LabelCopyright2;
	Coolctrls::TCoolBtn* BtnOk;
	Coolctrls::TCoolBevel* CoolBevel;
	Coolctrls::TCoolImages* CoolImages;
	Coolctrls::TCoolLabel* LabelText;
	void __fastcall ImageClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TFormAbout(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFormAbout(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFormAbout(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TFormAbout(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TFormAbout* FormAbout;

}	/* namespace Coolaboutunit */
using namespace Coolaboutunit;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolAboutUnit
