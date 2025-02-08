// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ColorListUnit.pas' rev: 4.00

#ifndef ColorListUnitHPP
#define ColorListUnitHPP

#pragma delphiheader begin
#pragma option push -w-
#include <CoolPolygons.hpp>	// Pascal unit
#include <CoolCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <CoolLists.hpp>	// Pascal unit
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

namespace Colorlistunit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TColorListForm;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TColorListForm : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Coolctrls::TCoolListBox* ColorBox;
	Buttons::TBitBtn* BtnOk;
	Buttons::TBitBtn* BtnCancel;
	Buttons::TBitBtn* BtnDelete;
	Forms::TScrollBox* ScrollBox;
	Extctrls::TImage* Image;
	Stdctrls::TLabel* Label1;
	Stdctrls::TLabel* Label2;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall BtnOkClick(System::TObject* Sender);
	void __fastcall ImageMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState 
		Shift, int X, int Y);
	void __fastcall BtnDeleteClick(System::TObject* Sender);
	
private:
	Coollists::TColorList* FColorList;
	void __fastcall SetColorList(Coollists::TColorList* Value);
	
public:
	__property Coollists::TColorList* ColorList = {read=FColorList, write=SetColorList};
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TColorListForm(Classes::TComponent* AOwner) : Forms::TForm(
		AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TColorListForm(Classes::TComponent* AOwner, int 
		Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TColorListForm(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TColorListForm(HWND ParentWindow) : Forms::TForm(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TColorListForm* ColorListForm;

}	/* namespace Colorlistunit */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Colorlistunit;
#endif
#pragma option pop	// -w-

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ColorListUnit
