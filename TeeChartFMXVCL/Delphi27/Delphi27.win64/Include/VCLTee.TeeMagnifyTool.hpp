// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeMagnifyTool.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeemagnifytoolHPP
#define Vcltee_TeemagnifytoolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Buttons.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeAnnToolEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teemagnifytool
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMagnifyTool;
class DELPHICLASS TMagnifyToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TMagnifyTool : public Vcltee::Teetools::TRectangleTool
{
	typedef Vcltee::Teetools::TRectangleTool inherited;
	
private:
	bool FCircled;
	bool FFollowMouse;
	double FPercent;
	bool FSmooth;
	int FWheelZoom;
	void __fastcall DrawLoupe();
	void __fastcall SetCircled(const bool Value);
	void __fastcall SetPercent(const double Value);
	void __fastcall SetSmooth(const bool Value);
	
protected:
	virtual void __fastcall ChartEvent(Vcltee::Teengine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Vcltee::Teengine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton AButton, System::Classes::TShiftState AShift, int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	virtual void __fastcall WheelMouseEvent(Vcltee::Teengine::TWheelMouseEvent AEvent, int WheelDelta, int X, int Y);
	
public:
	__fastcall virtual TMagnifyTool(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Active = {default=1};
	__property bool Circled = {read=FCircled, write=SetCircled, default=0};
	__property bool FollowMouse = {read=FFollowMouse, write=FFollowMouse, default=0};
	__property Pen;
	__property double Percent = {read=FPercent, write=SetPercent};
	__property bool Smooth = {read=FSmooth, write=SetSmooth, default=0};
	__property int WheelZoom = {read=FWheelZoom, write=FWheelZoom, default=5};
public:
	/* TAnnotationTool.Destroy */ inline __fastcall virtual ~TMagnifyTool() { }
	
};


class PASCALIMPLEMENTATION TMagnifyToolEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TCheckBox* CBFollow;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Comctrls::TTrackBar* TBFactor;
	Vcl::Stdctrls::TCheckBox* CBCircled;
	Vcl::Stdctrls::TLabel* Label9;
	Vcltee::Tecanvas::TComboFlat* CBCursor;
	Vcl::Stdctrls::TCheckBox* CBDrag;
	Vcl::Stdctrls::TCheckBox* CBResize;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDWheel;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Buttons::TSpeedButton* SpeedButton2;
	Vcl::Comctrls::TTabSheet* TabBorder;
	void __fastcall CBFollowClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall TBFactorChange(System::TObject* Sender);
	void __fastcall CBCircledClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CBCursorChange(System::TObject* Sender);
	void __fastcall CBDragClick(System::TObject* Sender);
	void __fastcall CBResizeClick(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	bool CreatingForm;
	Vcltee::Teeanntooledit::TAnnotationToolEdit* IAnnEditor;
	
public:
	TMagnifyTool* Zoom;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TMagnifyToolEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMagnifyToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TMagnifyToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TMagnifyToolEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teemagnifytool */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEMAGNIFYTOOL)
using namespace Vcltee::Teemagnifytool;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeemagnifytoolHPP
