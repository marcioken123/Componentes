// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeMoneyFlowFuncEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeemoneyflowfunceditHPP
#define Vcltee_TeemoneyflowfunceditHPP

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
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.StatChar.hpp>
#include <VCLTee.TeeCLVFunction.hpp>
#include <VCLTee.TeeBaseFuncEdit.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teemoneyflowfuncedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMoneyFlowFuncEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TMoneyFlowFuncEditor : public Vcltee::Teeclvfunction::TCLVFuncEditor
{
	typedef Vcltee::Teeclvfunction::TCLVFuncEditor inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label2;
	Vcltee::Tecanvas::TComboFlat* CBSeriesStyle;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcltee::Tecanvas::TButtonColor* BUpColor;
	Vcltee::Tecanvas::TButtonColor* BDownColor;
	Vcltee::Teependlg::TButtonPen* ButtonPen1;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBSeriesStyleChange(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TMoneyFlowFuncEditor(System::Classes::TComponent* AOwner) : Vcltee::Teeclvfunction::TCLVFuncEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMoneyFlowFuncEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeclvfunction::TCLVFuncEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TMoneyFlowFuncEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TMoneyFlowFuncEditor(HWND ParentWindow) : Vcltee::Teeclvfunction::TCLVFuncEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teemoneyflowfuncedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEMONEYFLOWFUNCEDIT)
using namespace Vcltee::Teemoneyflowfuncedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeemoneyflowfunceditHPP
