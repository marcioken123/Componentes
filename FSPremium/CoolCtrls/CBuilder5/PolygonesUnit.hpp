// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'PolygonesUnit.pas' rev: 5.00

#ifndef PolygonesUnitHPP
#define PolygonesUnitHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <CoolCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <CoolTools.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <CoolPolygons.hpp>	// Pascal unit
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

namespace Polygonesunit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPolygonesForm;
class PASCALIMPLEMENTATION TPolygonesForm : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Forms::TScrollBox* ScrollBox;
	Stdctrls::TButton* ButtonClearPoints;
	Stdctrls::TButton* ButtonOk;
	Stdctrls::TButton* ButtonCancel;
	Coolpolygons::TCoolPolygones* CoolPolygones;
	Stdctrls::TButton* ButtonClearPolygones;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall ButtonOkClick(System::TObject* Sender);
	void __fastcall ButtonClearPointsClick(System::TObject* Sender);
	void __fastcall ButtonClearPolygonesClick(System::TObject* Sender);
	
private:
	Coolpolygons::TPolygones* FPolygones;
	void __fastcall SetPolygones(Coolpolygons::TPolygones* Value);
	
public:
	__property Coolpolygons::TPolygones* Polygones = {read=FPolygones, write=SetPolygones};
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TPolygonesForm(Classes::TComponent* AOwner) : Forms::TForm(
		AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPolygonesForm(Classes::TComponent* AOwner, int 
		Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPolygonesForm(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TPolygonesForm(HWND ParentWindow) : Forms::TForm(
		ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TPolygonesForm* PolygonesForm;

}	/* namespace Polygonesunit */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Polygonesunit;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PolygonesUnit
