// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeClockEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeclockeditorHPP
#define Vcltee_TeeclockeditorHPP

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
#include <VCLTee.TeeBrushDlg.hpp>
#include <VCLTee.TeePoEdi.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeclockeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TClockEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TClockEditor : public Vcltee::Teepolareditor::TPolarSeriesEditor
{
	typedef Vcltee::Teepolareditor::TPolarSeriesEditor inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* CBRoman;
	Vcltee::Teependlg::TButtonPen* BRadius;
	Vcl::Comctrls::TTabSheet* TabHands;
	Vcl::Comctrls::TTabControl* TabControl1;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabHandBorder;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Comctrls::TTrackBar* TBSize;
	Vcl::Stdctrls::TLabel* LabelSize;
	Vcl::Comctrls::TTabSheet* TabHandBrush;
	Vcl::Stdctrls::TCheckBox* CBHandVisible;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Comctrls::TTrackBar* TBWidth;
	Vcl::Stdctrls::TLabel* LabelWidth;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Comctrls::TTrackBar* TBHeight;
	Vcl::Stdctrls::TLabel* LabelHeight;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Comctrls::TTrackBar* TBArrow;
	Vcl::Stdctrls::TLabel* LabelArrow;
	Vcl::Comctrls::TTabSheet* TabCenter;
	Vcl::Stdctrls::TCheckBox* CBCustom;
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBRomanClick(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall TBSizeChange(System::TObject* Sender);
	void __fastcall CBHandVisibleClick(System::TObject* Sender);
	void __fastcall TBWidthChange(System::TObject* Sender);
	void __fastcall TBHeightChange(System::TObject* Sender);
	void __fastcall PageControl2Change(System::TObject* Sender);
	void __fastcall TBArrowChange(System::TObject* Sender);
	HIDESBASE void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall CBCustomClick(System::TObject* Sender);
	void __fastcall DateTimePicker1Change(System::TObject* Sender);
	
private:
	Vcl::Comctrls::TDateTimePicker* DateTimePicker1;
	Vcltee::Teerose::TClockSeries* __fastcall Clock();
	Vcltee::Teerose::TClockHand* __fastcall CurrentHand();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TClockEditor(System::Classes::TComponent* AOwner) : Vcltee::Teepolareditor::TPolarSeriesEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TClockEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teepolareditor::TPolarSeriesEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TClockEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TClockEditor(HWND ParentWindow) : Vcltee::Teepolareditor::TPolarSeriesEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeclockeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECLOCKEDITOR)
using namespace Vcltee::Teeclockeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeclockeditorHPP
