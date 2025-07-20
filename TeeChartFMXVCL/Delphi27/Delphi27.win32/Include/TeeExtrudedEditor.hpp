// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeExtrudedEditor.pas' rev: 34.00 (Windows)

#ifndef TeeextrudededitorHPP
#define TeeextrudededitorHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Chart.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeeDragPoint.hpp>
#include <TeeExtruded.hpp>
#include <VCLTee.TeeGDIPlus.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeextrudededitor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TExtrudedEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TExtrudedEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcltee::Chart::TChart* Chart1;
	Vcltee::Series::TLineSeries* Series1;
	Vcltee::Teedragpoint::TDragPointTool* ChartTool1;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Buttons::TSpeedButton* SBDelete;
	Vcl::Stdctrls::TLabel* Label1;
	Vcltee::Tecanvas::TComboFlat* CBShow;
	Vcl::Stdctrls::TCheckBox* CBShowBounds;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall Chart1AfterDraw(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ChartTool1DragPoint(Vcltee::Teedragpoint::TDragPointTool* Sender, int Index);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall SBDeleteClick(System::TObject* Sender);
	void __fastcall Chart1MouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall CBShowChange(System::TObject* Sender);
	void __fastcall CBShowBoundsClick(System::TObject* Sender);
	
private:
	int ClickedPoint;
	bool IModified;
	Teeextruded::TPointCollection* Points;
	void __fastcall DrawClickedPoint();
	void __fastcall FillSeries();
	void __fastcall UpdateBlock();
	
public:
	void __fastcall RefreshPoints(Teeextruded::TPointCollection* const APoints);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TExtrudedEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TExtrudedEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TExtrudedEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TExtrudedEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeextrudededitor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEEXTRUDEDEDITOR)
using namespace Teeextrudededitor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeextrudededitorHPP
