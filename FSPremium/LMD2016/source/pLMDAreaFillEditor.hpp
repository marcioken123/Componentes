// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDAreaFillEditor.pas' rev: 31.00 (Windows)

#ifndef PlmdareafilleditorHPP
#define PlmdareafilleditorHPP

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
#include <System.Variants.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtDlgs.hpp>
#include <LMDChartBackground.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdareafilleditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDAreaFillEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDAreaFillEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TRadioGroup* RadioGroup1;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* tpSolid;
	Vcl::Comctrls::TTabSheet* tpGradient;
	Vcl::Comctrls::TTabSheet* tpImage;
	Vcl::Stdctrls::TButton* btCancel;
	Vcl::Stdctrls::TButton* btOK;
	Vcl::Extctrls::TPaintBox* pbSolidColor;
	Vcl::Stdctrls::TButton* btSolidColor;
	Vcl::Stdctrls::TButton* btGradientColor1;
	Vcl::Extctrls::TPaintBox* pbGradientColor1;
	Vcl::Extctrls::TPaintBox* pbGradientColor2;
	Vcl::Stdctrls::TButton* btGradientColor2;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Comctrls::TTrackBar* tbGradientAngle;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* edMaxLOD;
	Vcl::Stdctrls::TButton* btImage;
	Vcl::Extctrls::TRadioGroup* rgImageMode;
	Vcl::Extctrls::TImage* Image1;
	Vcl::Dialogs::TColorDialog* ColorDialog1;
	Vcl::Extdlgs::TOpenPictureDialog* OpenPictureDialog1;
	void __fastcall pbSolidColorPaint(System::TObject* Sender);
	void __fastcall pbGradientColor1Paint(System::TObject* Sender);
	void __fastcall pbGradientColor2Paint(System::TObject* Sender);
	void __fastcall RadioGroup1Click(System::TObject* Sender);
	void __fastcall rgImageModeClick(System::TObject* Sender);
	void __fastcall btSolidColorClick(System::TObject* Sender);
	void __fastcall btGradientColor1Click(System::TObject* Sender);
	void __fastcall btGradientColor2Click(System::TObject* Sender);
	void __fastcall tbGradientAngleChange(System::TObject* Sender);
	void __fastcall btImageClick(System::TObject* Sender);
	
private:
	System::Uitypes::TColor FSolidColor;
	System::Uitypes::TColor FColor1;
	System::Uitypes::TColor FColor2;
	Lmdchartbackground::TLMDChartBackgroundStyle FStyle;
	int FAngle;
	int FMaxLOD;
	Lmdchartbackground::TLMDChartBackground* FArea;
	
public:
	bool __fastcall Edit(Lmdchartbackground::TLMDChartBackground* AArea);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDAreaFillEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDAreaFillEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDAreaFillEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDAreaFillEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDAreaFillEditor* LMDAreaFillEditor;
}	/* namespace Plmdareafilleditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDAREAFILLEDITOR)
using namespace Plmdareafilleditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdareafilleditorHPP
