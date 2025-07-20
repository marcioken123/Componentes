// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeColorBandEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecolorbandeditHPP
#define Vcltee_TeecolorbandeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
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
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeAxisToolEdit.hpp>
#include <VCLTee.TeeEdiGrad.hpp>
#include <VCLTee.TeeColorLineEditor.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecolorbandedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TColorBandToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TColorBandToolEditor : public Vcltee::Teeaxistooledit::TAxisToolEditor
{
	typedef Vcltee::Teeaxistooledit::TAxisToolEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabStart;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcltee::Tecanvas::TButtonColor* ButtonColor1;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* ETrans;
	Vcl::Comctrls::TUpDown* UDTrans;
	Vcl::Stdctrls::TCheckBox* CBDrawBehind;
	Vcl::Stdctrls::TCheckBox* CBBeforeAxes;
	Vcl::Stdctrls::TLabel* Label5;
	Vcltee::Tecanvas::TComboFlat* CBCursor;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Comctrls::TTabSheet* TabPattern;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabEnd;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* EStart;
	Vcl::Stdctrls::TCheckBox* CBStart;
	Vcl::Stdctrls::TCheckBox* CBStartActive;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* EEnd;
	Vcl::Stdctrls::TCheckBox* CBEnd;
	Vcl::Stdctrls::TCheckBox* CBEndActive;
	Vcl::Stdctrls::TCheckBox* CBAllowDrag;
	Vcl::Comctrls::TTabSheet* TabPicture;
	Vcl::Stdctrls::TCheckBox* CBStartAnnValue;
	Vcl::Stdctrls::TCheckBox* CBEndAnnValue;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall EStartChange(System::TObject* Sender);
	void __fastcall EEndChange(System::TObject* Sender);
	void __fastcall ETransChange(System::TObject* Sender);
	void __fastcall CBDrawBehindClick(System::TObject* Sender);
	void __fastcall CBStartClick(System::TObject* Sender);
	void __fastcall CBEndClick(System::TObject* Sender);
	void __fastcall CBBeforeAxesClick(System::TObject* Sender);
	void __fastcall CBCursorChange(System::TObject* Sender);
	void __fastcall CBStartActiveClick(System::TObject* Sender);
	void __fastcall CBEndActiveClick(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall CBAllowDragClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBStartAnnValueClick(System::TObject* Sender);
	void __fastcall CBEndAnnValueClick(System::TObject* Sender);
	
private:
	Vcltee::Teetools::TColorBandTool* ColorBandTool;
	Vcltee::Teecolorlineeditor::TColorLineToolEditor* IStart;
	Vcltee::Teecolorlineeditor::TColorLineToolEditor* IEnd;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TColorBandToolEditor(System::Classes::TComponent* AOwner) : Vcltee::Teeaxistooledit::TAxisToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TColorBandToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeaxistooledit::TAxisToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TColorBandToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TColorBandToolEditor(HWND ParentWindow) : Vcltee::Teeaxistooledit::TAxisToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecolorbandedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECOLORBANDEDIT)
using namespace Vcltee::Teecolorbandedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecolorbandeditHPP
