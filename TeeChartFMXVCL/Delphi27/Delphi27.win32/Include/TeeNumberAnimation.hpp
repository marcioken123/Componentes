// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeNumberAnimation.pas' rev: 34.00 (Windows)

#ifndef TeenumberanimationHPP
#define TeenumberanimationHPP

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
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeDragPoint.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <TeeActionGallery.hpp>
#include <TeeSelectProperty.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeGDIPlus.hpp>
#include <VCLTee.TeeAnimationEditor.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teenumberanimation
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TNumberAnimationEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TNumberAnimationEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabCurve;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TListBox* LBCurveType;
	Vcltee::Chart::TChart* Chart1;
	Vcltee::Series::TLineSeries* Series1;
	Vcltee::Teedragpoint::TDragPointTool* ChartTool1;
	Vcltee::Teetools::TColorLineTool* ChartTool2;
	Vcl::Comctrls::TTabSheet* TabGeneral;
	Vcl::Stdctrls::TButton* BDelete;
	Vcltee::Tecanvas::TComboFlat* ComboMode;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TButton* Button4;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Stdctrls::TButton* BClearStartLink;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* EStart;
	Vcl::Buttons::TSpeedButton* StartColor;
	Vcl::Stdctrls::TCheckBox* CBUseStart;
	Vcl::Stdctrls::TLabel* LStartLink;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TButton* BClearEndLink;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Buttons::TSpeedButton* EndColor;
	Vcl::Stdctrls::TEdit* EEnd;
	Vcl::Stdctrls::TCheckBox* CBKeepEnd;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TLabel* LabelProperty;
	Vcl::Stdctrls::TLabel* LEndLink;
	Vcl::Stdctrls::TCheckBox* CBUseEnd;
	void __fastcall ChartTool1DragPoint(Vcltee::Teedragpoint::TDragPointTool* Sender, int Index);
	void __fastcall Chart1ClickSeries(Vcltee::Chart::TCustomChart* Sender, Vcltee::Teengine::TChartSeries* Series, int ValueIndex, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall ChartTool1StartDrag(Vcltee::Teedragpoint::TDragPointTool* Sender, int Index, bool &Start);
	void __fastcall LBCurveTypeClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBUseStartClick(System::TObject* Sender);
	void __fastcall EStartChange(System::TObject* Sender);
	void __fastcall EEndChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall BDeleteClick(System::TObject* Sender);
	void __fastcall Chart1AfterDraw(System::TObject* Sender);
	void __fastcall CBKeepEndClick(System::TObject* Sender);
	void __fastcall ComboModeChange(System::TObject* Sender);
	void __fastcall StartColorClick(System::TObject* Sender);
	void __fastcall EndColorClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall BClearStartLinkClick(System::TObject* Sender);
	void __fastcall BClearEndLinkClick(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall CBUseEndClick(System::TObject* Sender);
	
private:
	Vcltee::Teeanimate::TNumberAnimation* Animation;
	int Selected;
	Vcltee::Teeanimationeditor::TAnimationEditor* IBasic;
	void __fastcall AddCurve();
	bool __fastcall AskLink(Vcltee::Teeanimate::TPropertyLink* ALink);
	int __fastcall ClickedPointer();
	void __fastcall RefreshValues();
	void __fastcall SetLinkLabel(Vcl::Stdctrls::TLabel* ALabel, Vcltee::Teeanimate::TPropertyLink* ALink);
	
public:
	__classmethod bool __fastcall EditProperty(System::Classes::TComponent* AOwner, Vcltee::Teeanimate::TPropertyAnimation* Animation);
	void __fastcall RefreshAnimation(Vcltee::Teeanimate::TNumberAnimation* AAnimation);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TNumberAnimationEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TNumberAnimationEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TNumberAnimationEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TNumberAnimationEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teenumberanimation */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEENUMBERANIMATION)
using namespace Teenumberanimation;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeenumberanimationHPP
