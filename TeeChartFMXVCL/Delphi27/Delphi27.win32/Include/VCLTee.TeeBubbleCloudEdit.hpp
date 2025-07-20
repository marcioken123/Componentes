// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeBubbleCloudEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeebubblecloudeditHPP
#define Vcltee_TeebubblecloudeditHPP

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
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teebubblecloudedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBubbleCloudEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBubbleCloudEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabBrush;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Comctrls::TTrackBar* TBTransp;
	Vcl::Stdctrls::TLabel* LTransp;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Comctrls::TTrackBar* TBRotation;
	Vcl::Stdctrls::TLabel* LRotation;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Comctrls::TTrackBar* TBSeparation;
	Vcl::Stdctrls::TLabel* LSeparation;
	Vcltee::Tecanvas::TComboFlat* CBUnits;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Comctrls::TTrackBar* TBRatio;
	Vcl::Stdctrls::TLabel* LSizeRatio;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall TBRotationChange(System::TObject* Sender);
	void __fastcall TBSeparationChange(System::TObject* Sender);
	void __fastcall CBUnitsChange(System::TObject* Sender);
	void __fastcall TBRatioChange(System::TObject* Sender);
	
protected:
	Vcl::Forms::TCustomForm* Grid3DForm;
	Vcltee::Teesurfa::TBubbleCloudSeries* Series;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TBubbleCloudEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TBubbleCloudEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TBubbleCloudEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TBubbleCloudEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teebubblecloudedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEBUBBLECLOUDEDIT)
using namespace Vcltee::Teebubblecloudedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeebubblecloudeditHPP
