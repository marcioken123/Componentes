// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeWindRoseEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeewindroseeditorHPP
#define Vcltee_TeewindroseeditorHPP

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
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeePolarEditor.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeRose.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teewindroseeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TWindRoseEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TWindRoseEditor : public Vcltee::Teepolareditor::TPolarSeriesEditor
{
	typedef Vcltee::Teepolareditor::TPolarSeriesEditor inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* CBMirrorAngles;
	Vcl::Stdctrls::TCheckBox* CBMirror;
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBMirrorClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBMirrorAnglesClick(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TWindRoseEditor(System::Classes::TComponent* AOwner) : Vcltee::Teepolareditor::TPolarSeriesEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TWindRoseEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teepolareditor::TPolarSeriesEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TWindRoseEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TWindRoseEditor(HWND ParentWindow) : Vcltee::Teepolareditor::TPolarSeriesEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teewindroseeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEWINDROSEEDITOR)
using namespace Vcltee::Teewindroseeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeewindroseeditorHPP
