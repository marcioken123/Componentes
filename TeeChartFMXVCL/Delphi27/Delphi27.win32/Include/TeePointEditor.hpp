// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeePointEditor.pas' rev: 34.00 (Windows)

#ifndef TeepointeditorHPP
#define TeepointeditorHPP

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
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <TeeBlocks.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teepointeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPointEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPointEditor : public Vcltee::Tecanvas::TVisualEditor
{
	typedef Vcltee::Tecanvas::TVisualEditor inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label58;
	Vcl::Stdctrls::TLabel* LabelPathY;
	Vcl::Stdctrls::TLabel* Label60;
	Vcl::Stdctrls::TLabel* PathX;
	Vcl::Stdctrls::TLabel* PathY;
	Vcl::Stdctrls::TLabel* PathZ;
	Vcl::Stdctrls::TScrollBar* BlockPathX;
	Vcl::Stdctrls::TScrollBar* BlockPathY;
	Vcl::Stdctrls::TScrollBar* BlockPathZ;
	Vcltee::Tecanvas::TButtonColor* BlockPathColor;
	Vcl::Stdctrls::TCheckBox* BlockPathDefault;
	void __fastcall BlockPathXChange(System::TObject* Sender);
	void __fastcall BlockPathYChange(System::TObject* Sender);
	void __fastcall BlockPathZChange(System::TObject* Sender);
	void __fastcall BlockPathColorClick(System::TObject* Sender);
	void __fastcall BlockPathDefaultClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	bool IModifying;
	Vcltee::Tecanvas::TPointXYZFloat* Current;
	
public:
	double Factor;
	void __fastcall SelectPoint(Vcltee::Tecanvas::TPointXYZFloat* const APoint);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPointEditor(System::Classes::TComponent* AOwner) : Vcltee::Tecanvas::TVisualEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPointEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Tecanvas::TVisualEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPointEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPointEditor(HWND ParentWindow) : Vcltee::Tecanvas::TVisualEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teepointeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEPOINTEDITOR)
using namespace Teepointeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeepointeditorHPP
