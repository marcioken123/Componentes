// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeBarJoinEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeebarjoineditorHPP
#define Vcltee_TeebarjoineditorHPP

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
#include <VCLTee.TeeBarEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeGalleryPanel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teebarjoineditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBarJoinEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBarJoinEditor : public Vcltee::Teebaredit::TBarSeriesEditor
{
	typedef Vcltee::Teebaredit::TBarSeriesEditor inherited;
	
__published:
	Vcltee::Teependlg::TButtonPen* BJoin;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TBarJoinEditor(System::Classes::TComponent* AOwner) : Vcltee::Teebaredit::TBarSeriesEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TBarJoinEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teebaredit::TBarSeriesEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TBarJoinEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TBarJoinEditor(HWND ParentWindow) : Vcltee::Teebaredit::TBarSeriesEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teebarjoineditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEBARJOINEDITOR)
using namespace Vcltee::Teebarjoineditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeebarjoineditorHPP
