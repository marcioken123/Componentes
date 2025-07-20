// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeProperties.pas' rev: 34.00 (Windows)

#ifndef TeepropertiesHPP
#define TeepropertiesHPP

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
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <TeeBlocks.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeproperties
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPropertiesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPropertiesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* BRemove;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Stdctrls::TListBox* ListProperties;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* EName;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* EValue;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* LValue;
	Vcl::Stdctrls::TButton* BChange;
	void __fastcall BRemoveClick(System::TObject* Sender);
	void __fastcall ListPropertiesClick(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall BChangeClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall EValueChange(System::TObject* Sender);
	
private:
	void __fastcall VerifyName(const System::UnicodeString AName, int AIndex);
	
public:
	Teeblocks::TObjectProperties* Properties;
	__classmethod bool __fastcall ModalShow(System::Classes::TComponent* AOwner, Teeblocks::TObjectProperties* AProperties);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPropertiesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPropertiesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPropertiesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPropertiesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeproperties */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEPROPERTIES)
using namespace Teeproperties;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeepropertiesHPP
