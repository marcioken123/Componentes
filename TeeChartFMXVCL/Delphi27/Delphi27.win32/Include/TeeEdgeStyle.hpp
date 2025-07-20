// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeEdgeStyle.pas' rev: 34.00 (Windows)

#ifndef TeeedgestyleHPP
#define TeeedgestyleHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <TeeBlocks.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeedgestyle
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TEdgeEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TEdgeEditor : public Vcltee::Tecanvas::TVisualEditor
{
	typedef Vcltee::Tecanvas::TVisualEditor inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* GroupBox11;
	Vcl::Stdctrls::TLabel* Label18;
	Vcl::Stdctrls::TLabel* Label28;
	Vcl::Stdctrls::TLabel* Label30;
	Vcl::Stdctrls::TScrollBar* BlockPieRoundX;
	Vcl::Stdctrls::TScrollBar* BlockPieRoundY;
	Vcltee::Tecanvas::TComboFlat* BlockRoundStyle;
	Vcl::Stdctrls::TEdit* EBlockRoundSlices;
	Vcl::Comctrls::TUpDown* BlockRoundSlices;
	Vcl::Stdctrls::TLabel* LRoundX;
	Vcl::Stdctrls::TLabel* LRoundY;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall BlockPieRoundXChange(System::TObject* Sender);
	void __fastcall BlockPieRoundYChange(System::TObject* Sender);
	void __fastcall BlockRoundStyleChange(System::TObject* Sender);
	void __fastcall EBlockRoundSlicesChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	bool IModifying;
	
public:
	Teeblocks::TBlockEdge* Edge;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TEdgeEditor(System::Classes::TComponent* AOwner) : Vcltee::Tecanvas::TVisualEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TEdgeEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Tecanvas::TVisualEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TEdgeEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TEdgeEditor(HWND ParentWindow) : Vcltee::Tecanvas::TVisualEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeedgestyle */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEEDGESTYLE)
using namespace Teeedgestyle;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeedgestyleHPP
