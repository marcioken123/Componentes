// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeLinePointEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeelinepointeditorHPP
#define Vcltee_TeelinepointeditorHPP

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
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeePoEdi.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeGalleryPanel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teelinepointeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLinePointEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLinePointEditor : public Vcltee::Teepoedi::TSeriesPointerEditor
{
	typedef Vcltee::Teepoedi::TSeriesPointerEditor inherited;
	
__published:
	Vcltee::Teependlg::TButtonPen* BLines;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLinePointEditor(System::Classes::TComponent* AOwner) : Vcltee::Teepoedi::TSeriesPointerEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLinePointEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teepoedi::TSeriesPointerEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLinePointEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLinePointEditor(HWND ParentWindow) : Vcltee::Teepoedi::TSeriesPointerEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teelinepointeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEELINEPOINTEDITOR)
using namespace Vcltee::Teelinepointeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeelinepointeditorHPP
