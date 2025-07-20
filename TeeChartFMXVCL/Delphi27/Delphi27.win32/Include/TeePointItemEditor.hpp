// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeePointItemEditor.pas' rev: 34.00 (Windows)

#ifndef TeepointitemeditorHPP
#define TeepointitemeditorHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <TeeBlocks.hpp>
#include <TeeExtruded.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teepointitemeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPointItemEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPointItemEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* EX;
	Vcl::Stdctrls::TEdit* EY;
	Vcl::Stdctrls::TEdit* EZ;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TLabel* LabelLink;
	Vcl::Stdctrls::TButton* BClearLink;
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall BClearLinkClick(System::TObject* Sender);
	void __fastcall EXChange(System::TObject* Sender);
	void __fastcall EYChange(System::TObject* Sender);
	void __fastcall EZChange(System::TObject* Sender);
	
private:
	Teeblocks::TBlocks* Blocks;
	Teeextruded::TPointItem* Point;
	void __fastcall RefreshLink();
	
public:
	void __fastcall RefreshPoint(Teeextruded::TPointItem* APoint, Teeblocks::TBlocks* ABlocks);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPointItemEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPointItemEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPointItemEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPointItemEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teepointitemeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEPOINTITEMEDITOR)
using namespace Teepointitemeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeepointitemeditorHPP
