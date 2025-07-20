// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeAxisToolEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeaxistooleditHPP
#define Vcltee_TeeaxistooleditHPP

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
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeaxistooledit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAxisToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAxisToolEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcltee::Teependlg::TButtonPen* BPen;
	Vcltee::Tecanvas::TComboFlat* CBAxis;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Extctrls::TPanel* PanelTop;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBAxisChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	int __fastcall DepthAxesOffset();
	
protected:
	Vcltee::Teengine::TTeeCustomTool* AxisTool;
	bool IncludeDepthAxes;
	virtual Vcltee::Teengine::TChartAxis* __fastcall GetAxis();
	virtual void __fastcall SetAxis(Vcltee::Teengine::TChartAxis* const AAxis);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAxisToolEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAxisToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAxisToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAxisToolEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeaxistooledit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEAXISTOOLEDIT)
using namespace Vcltee::Teeaxistooledit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeaxistooleditHPP
