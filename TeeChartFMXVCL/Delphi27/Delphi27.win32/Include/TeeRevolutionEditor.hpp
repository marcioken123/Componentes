// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeRevolutionEditor.pas' rev: 34.00 (Windows)

#ifndef TeerevolutioneditorHPP
#define TeerevolutioneditorHPP

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
#include <Vcl.Menus.hpp>
#include <Vcl.ComCtrls.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeDragPoint.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeBezie.hpp>
#include <TeeRevolution.hpp>
#include <VCLTee.EditChar.hpp>
#include <TeeExtruded.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teerevolutioneditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRevolutionPointsEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TRevolutionPointsEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcltee::Chart::TChart* Chart1;
	Vcltee::Teedragpoint::TDragPointTool* ChartTool1;
	Vcltee::Teetools::TColorLineTool* ChartTool2;
	Vcl::Buttons::TSpeedButton* SBAddPoint;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Buttons::TSpeedButton* SBDelete;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Menus::TMenuItem* Addnewpoint1;
	Vcl::Menus::TMenuItem* Insertnewpoint1;
	Vcl::Menus::TMenuItem* Deletepoint1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* EBezier;
	Vcl::Comctrls::TUpDown* UDBezier;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* ESlices;
	Vcl::Comctrls::TUpDown* UDSlices;
	Vcltee::Teebezie::TBezierSeries* Series1;
	Vcltee::Teebezie::TBezierSeries* Series2;
	Vcl::Stdctrls::TLabel* LabelPoint;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* EditChart1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall SBAddPointClick(System::TObject* Sender);
	void __fastcall ChartTool1DragPoint(Vcltee::Teedragpoint::TDragPointTool* Sender, int Index);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall Chart1MouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall Chart1AfterDraw(System::TObject* Sender);
	void __fastcall Chart1MouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall Addnewpoint1Click(System::TObject* Sender);
	void __fastcall SBDeleteClick(System::TObject* Sender);
	void __fastcall PopupMenu1Popup(System::TObject* Sender);
	void __fastcall Insertnewpoint1Click(System::TObject* Sender);
	void __fastcall Panel1DblClick(System::TObject* Sender);
	void __fastcall EBezierChange(System::TObject* Sender);
	Vcltee::Teengine::TSeriesPointerStyle __fastcall Series1GetPointerStyle(Vcltee::Teengine::TChartSeries* Sender, int ValueIndex);
	void __fastcall ESlicesChange(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall EditChart1Click(System::TObject* Sender);
	
private:
	Teerevolution::TRevolutionBlock* Block;
	int ClickedPoint;
	int SelectedIndex;
	void __fastcall AddPointsToBlock();
	void __fastcall DoRefresh();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TRevolutionPointsEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRevolutionPointsEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRevolutionPointsEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRevolutionPointsEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teerevolutioneditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEREVOLUTIONEDITOR)
using namespace Teerevolutioneditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeerevolutioneditorHPP
