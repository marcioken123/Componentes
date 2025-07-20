// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeCandlEdi.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecandlediHPP
#define Vcltee_TeecandlediHPP

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
#include <VCLTee.Series.hpp>
#include <VCLTee.CandleCh.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeComma.hpp>
#include <VCLTee.TeeEdiGrad.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecandledi
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCandleEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCandleEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Comctrls::TTabSheet* TabColors;
	Vcl::Extctrls::TRadioGroup* RGStyle;
	Vcl::Stdctrls::TCheckBox* CBShowOpen;
	Vcl::Stdctrls::TCheckBox* CBShowClose;
	Vcl::Stdctrls::TCheckBox* CBDraw3D;
	Vcl::Stdctrls::TCheckBox* CBDark3D;
	Vcl::Comctrls::TTabSheet* TabSize;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* SEWidth;
	Vcl::Comctrls::TUpDown* UDWidth;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* SEDepth;
	Vcl::Comctrls::TUpDown* UDDepth;
	Vcl::Stdctrls::TCheckBox* CBAutoSize;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Stdctrls::TCheckBox* CBRemoveGaps;
	Vcl::Comctrls::TTabSheet* TabHighLow;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* Label5;
	Vcltee::Tecanvas::TComboFlat* CBHighLowColor;
	Vcl::Stdctrls::TLabel* Label6;
	Vcltee::Tecanvas::TComboFlat* CBBorderColor;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Comctrls::TTrackBar* TBTransp;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TLabel* Label2;
	Vcltee::Tecanvas::TComboFlat* CBColorStyle;
	Vcl::Comctrls::TPageControl* PageControl3;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabGradients;
	Vcltee::Tecanvas::TButtonColor* BUpClose;
	Vcltee::Tecanvas::TButtonColor* BDownClose;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabUp;
	Vcl::Comctrls::TTabSheet* TabDown;
	Vcl::Stdctrls::TCheckBox* CBInflate;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall RGStyleClick(System::TObject* Sender);
	void __fastcall SEWidthChange(System::TObject* Sender);
	void __fastcall CBShowOpenClick(System::TObject* Sender);
	void __fastcall CBShowCloseClick(System::TObject* Sender);
	void __fastcall CBDraw3DClick(System::TObject* Sender);
	void __fastcall CBDark3DClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBColorStyleChange(System::TObject* Sender);
	void __fastcall SEDepthChange(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall CBAutoSizeClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall CBRemoveGapsClick(System::TObject* Sender);
	void __fastcall CBHighLowColorChange(System::TObject* Sender);
	void __fastcall CBBorderColorChange(System::TObject* Sender);
	void __fastcall PageControl2Change(System::TObject* Sender);
	void __fastcall PageControl3Change(System::TObject* Sender);
	void __fastcall CBInflateClick(System::TObject* Sender);
	
private:
	Vcltee::Candlech::TCandleSeries* Candle;
	void __fastcall RefreshControls();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TCandleEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCandleEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCandleEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCandleEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecandledi */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECANDLEDI)
using namespace Vcltee::Teecandledi;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecandlediHPP
