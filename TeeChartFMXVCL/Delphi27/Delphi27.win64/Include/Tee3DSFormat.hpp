// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tee3DSFormat.pas' rev: 34.00 (Windows)

#ifndef Tee3dsformatHPP
#define Tee3dsformatHPP

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
#include <VCLTee.TeCanvas.hpp>
#include <TeeBlocks.hpp>
#include <TeeObjFormat.hpp>
#include <TeeFacesBlock.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Tee3dsformat
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS T3DSObject;
class DELPHICLASS TBlock3DSEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION T3DSObject : public Teeobjformat::TBaseObjBlock
{
	typedef Teeobjformat::TBaseObjBlock inherited;
	
protected:
	System::Classes::TStrings* IDebug;
	DYNAMIC System::UnicodeString __fastcall GetEditor();
	Vcltee::Tecanvas::TRGB __fastcall GetMaterialColor(int Material);
	virtual void __fastcall LoadItems(const System::UnicodeString ASource, const System::UnicodeString AFile);
	
__published:
	__property Items;
	__property LinkFile = {default=0};
	__property Properties;
public:
	/* TBaseObjBlock.Create */ inline __fastcall virtual T3DSObject(System::Classes::TComponent* AOwner) : Teeobjformat::TBaseObjBlock(AOwner) { }
	/* TBaseObjBlock.Destroy */ inline __fastcall virtual ~T3DSObject() { }
	
};


class PASCALIMPLEMENTATION TBlock3DSEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
public:
	/* TCustomForm.Create */ inline __fastcall virtual TBlock3DSEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TBlock3DSEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TBlock3DSEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TBlock3DSEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define Tee3DSExtension L".3ds"
}	/* namespace Tee3dsformat */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEE3DSFORMAT)
using namespace Tee3dsformat;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Tee3dsformatHPP
