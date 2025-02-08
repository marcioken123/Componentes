// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'PointListUnit.pas' rev: 5.00

#ifndef PointListUnitHPP
#define PointListUnitHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <CoolLists.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <CoolCtrls.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
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

namespace Pointlistunit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPointListForm;
class PASCALIMPLEMENTATION TPointListForm : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Coolctrls::TCoolStringGrid* PointsGrid;
	Buttons::TBitBtn* BtnAdd;
	Buttons::TBitBtn* BtnInsert;
	Buttons::TBitBtn* BtnDelete;
	Buttons::TBitBtn* BtnOk;
	Buttons::TBitBtn* BtnCancel;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PointsGridGetEditMask(System::TObject* Sender, int ACol, int ARow, AnsiString &Value
		);
	void __fastcall BtnAddClick(System::TObject* Sender);
	void __fastcall BtnDeleteClick(System::TObject* Sender);
	void __fastcall BtnInsertClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BtnOkClick(System::TObject* Sender);
	
private:
	Coollists::TPointList* FPointList;
	void __fastcall SetPointList(Coollists::TPointList* Value);
	
public:
	__property Coollists::TPointList* PointList = {read=FPointList, write=SetPointList};
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TPointListForm(Classes::TComponent* AOwner) : Forms::TForm(
		AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPointListForm(Classes::TComponent* AOwner, int 
		Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPointListForm(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TPointListForm(HWND ParentWindow) : Forms::TForm(
		ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TPointListForm* PointListForm;

}	/* namespace Pointlistunit */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Pointlistunit;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PointListUnit
