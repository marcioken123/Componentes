// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeText3D.pas' rev: 34.00 (Windows)

#ifndef Vcltee_Teetext3dHPP
#define Vcltee_Teetext3dHPP

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
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeEdiFont.hpp>
#include <VCLTee.TeeBrushDlg.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teetext3d
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TText3DTool;
class DELPHICLASS TText3DEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TText3DTool : public Vcltee::Teengine::TTeeCustomTool
{
	typedef Vcltee::Teengine::TTeeCustomTool inherited;
	
	
private:
	typedef System::DynamicArray<int> _TText3DTool__1;
	
	typedef System::DynamicArray<bool> _TText3DTool__2;
	
	typedef System::DynamicArray<Vcltee::Tecanvas::TPointArray> _TText3DTool__3;
	
	
private:
	double FAngle;
	Vcltee::Tecanvas::TTeeFont* FFont;
	Vcltee::Tecanvas::TFloatXYZ* FPosition;
	Vcltee::Tecanvas::TFloatXYZ* FRotation;
	System::UnicodeString FText;
	bool IDirty;
	void __fastcall Changed(System::TObject* Sender);
	void __fastcall DestroyPolygons();
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall SetAngle(const double Value);
	void __fastcall SetFont(Vcltee::Tecanvas::TTeeFont* const Value);
	void __fastcall SetPosition(Vcltee::Tecanvas::TFloatXYZ* const Value);
	void __fastcall SetRotation(Vcltee::Tecanvas::TFloatXYZ* const Value);
	void __fastcall SetText(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall ChartEvent(Vcltee::Teengine::TChartToolEvent AEvent);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	_TText3DTool__1 Clipped;
	_TText3DTool__2 Interior;
	int PolygonCount;
	_TText3DTool__3 Polygons;
	__fastcall virtual TText3DTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TText3DTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Active = {default=1};
	__property double Angle = {read=FAngle, write=SetAngle};
	__property Brush;
	__property Vcltee::Tecanvas::TTeeFont* Font = {read=FFont, write=SetFont};
	__property Pen;
	__property Vcltee::Tecanvas::TFloatXYZ* Position = {read=FPosition, write=SetPosition};
	__property Vcltee::Tecanvas::TFloatXYZ* Rotation = {read=FRotation, write=SetRotation};
	__property System::UnicodeString Text = {read=FText, write=SetText};
};


class PASCALIMPLEMENTATION TText3DEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabFont;
	Vcl::Stdctrls::TMemo* MemoText;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TEdit* ECustLeft;
	Vcl::Comctrls::TUpDown* UDLeft;
	Vcl::Stdctrls::TEdit* ECustTop;
	Vcl::Comctrls::TUpDown* UDTop;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDZ;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Comctrls::TTrackBar* TBRotation;
	Vcl::Stdctrls::TLabel* LRotation;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Comctrls::TTrackBar* TBElevation;
	Vcl::Stdctrls::TLabel* LElevation;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Comctrls::TTrackBar* TBTilt;
	Vcl::Stdctrls::TLabel* LTilt;
	Vcl::Comctrls::TTabSheet* TabPattern;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Comctrls::TTabSheet* TabBorder;
	void __fastcall ECustLeftChange(System::TObject* Sender);
	void __fastcall ECustTopChange(System::TObject* Sender);
	void __fastcall MemoTextChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall TBRotationChange(System::TObject* Sender);
	void __fastcall TBElevationChange(System::TObject* Sender);
	void __fastcall TBTiltChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	TText3DTool* Tool;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TText3DEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TText3DEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TText3DEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TText3DEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teetext3d */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETEXT3D)
using namespace Vcltee::Teetext3d;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_Teetext3dHPP
