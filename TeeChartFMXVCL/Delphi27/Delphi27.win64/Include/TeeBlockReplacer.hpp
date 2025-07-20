// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeBlockReplacer.pas' rev: 34.00 (Windows)

#ifndef TeeblockreplacerHPP
#define TeeblockreplacerHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <TeeMakerControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeblockreplacer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBlockReplacer;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBlockReplacer : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TButton* BOk;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Extctrls::TPanel* PanelOld;
	Vcl::Extctrls::TPanel* PanelNew;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Stdctrls::TButton* Button4;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	
private:
	void __fastcall ShowGallery(Teemakercontrol::TMaker* AMaker);
	
public:
	Teemakercontrol::TMaker* MakerOld;
	Teemakercontrol::TMaker* MakerNew;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TBlockReplacer(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TBlockReplacer(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TBlockReplacer() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TBlockReplacer(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeblockreplacer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEBLOCKREPLACER)
using namespace Teeblockreplacer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeblockreplacerHPP
