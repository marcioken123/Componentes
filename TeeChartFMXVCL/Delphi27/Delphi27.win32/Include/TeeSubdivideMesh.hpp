// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeSubdivideMesh.pas' rev: 34.00 (Windows)

#ifndef TeesubdividemeshHPP
#define TeesubdividemeshHPP

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
#include <TeeFacesBlock.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teesubdividemesh
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSubDivideMesh;
class DELPHICLASS TSubDivideEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TSubDivideMesh : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Teefacesblock::TFacesBlock* Face;
	
public:
	__fastcall TSubDivideMesh(Teefacesblock::TFacesBlock* const AFace);
	__fastcall virtual ~TSubDivideMesh();
	void __fastcall SubDivide();
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TSubDivideEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSubDivideEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSubDivideEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSubDivideEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSubDivideEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teesubdividemesh */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEESUBDIVIDEMESH)
using namespace Teesubdividemesh;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeesubdividemeshHPP
