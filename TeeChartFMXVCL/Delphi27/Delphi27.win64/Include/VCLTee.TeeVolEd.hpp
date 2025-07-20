// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeVolEd.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeevoledHPP
#define Vcltee_TeevoledHPP

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
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.CandleCh.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeGalleryPanel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teevoled
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TVolumeSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TVolumeSeriesEditor : public Vcltee::Teependlg::TPenDialog
{
	typedef Vcltee::Teependlg::TPenDialog inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* CBColorEach;
	Vcl::Stdctrls::TCheckBox* CBUseOrigin;
	Vcl::Stdctrls::TEdit* EOrigin;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBColorEachClick(System::TObject* Sender);
	HIDESBASE void __fastcall BColorClick(System::TObject* Sender);
	void __fastcall CBUseOriginClick(System::TObject* Sender);
	void __fastcall EOriginChange(System::TObject* Sender);
	
private:
	Vcltee::Candlech::TVolumeSeries* TheSeries;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TVolumeSeriesEditor(System::Classes::TComponent* AOwner) : Vcltee::Teependlg::TPenDialog(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TVolumeSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teependlg::TPenDialog(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TVolumeSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TVolumeSeriesEditor(HWND ParentWindow) : Vcltee::Teependlg::TPenDialog(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teevoled */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEVOLED)
using namespace Vcltee::Teevoled;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeevoledHPP
