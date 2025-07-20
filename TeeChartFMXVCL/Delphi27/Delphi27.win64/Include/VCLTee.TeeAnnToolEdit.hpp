// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeAnnToolEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeanntooleditHPP
#define Vcltee_TeeanntooleditHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeTextShapeEditor.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeanntooledit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAnnotationToolEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAnnotationToolEdit : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabShape;
	Vcl::Comctrls::TTabSheet* TabPosition;
	Vcl::Stdctrls::TLabel* Label2;
	Vcltee::Tecanvas::TComboFlat* CBPos;
	Vcl::Stdctrls::TCheckBox* CBCustPos;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TEdit* ECustLeft;
	Vcl::Comctrls::TUpDown* UDLeft;
	Vcl::Stdctrls::TEdit* ECustTop;
	Vcl::Comctrls::TUpDown* UDTop;
	Vcl::Comctrls::TTabSheet* TabCallout;
	Vcl::Stdctrls::TLabel* Label13;
	Vcltee::Tecanvas::TComboFlat* CBUnits;
	Vcl::Comctrls::TTabSheet* TabSize;
	Vcl::Stdctrls::TLabel* Label14;
	Vcl::Stdctrls::TLabel* Label15;
	Vcl::Stdctrls::TEdit* ECustWidth;
	Vcl::Stdctrls::TEdit* ECustHeight;
	Vcl::Comctrls::TUpDown* UDWidth;
	Vcl::Comctrls::TUpDown* UDHeight;
	Vcl::Stdctrls::TCheckBox* CBAutoSize;
	Vcl::Stdctrls::TCheckBox* CBDraw3D;
	Vcl::Stdctrls::TLabel* LabelZ;
	Vcl::Stdctrls::TEdit* EPosZ;
	Vcl::Comctrls::TUpDown* UDZPos;
	Vcl::Comctrls::TPageControl* PageControl3;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabPointer;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TEdit* EX;
	Vcl::Stdctrls::TEdit* EY;
	Vcl::Stdctrls::TEdit* EZ;
	Vcl::Stdctrls::TEdit* EArrowDist;
	Vcl::Comctrls::TUpDown* UDArrowDist;
	Vcltee::Tecanvas::TComboFlat* CBHead;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDHeadSize;
	Vcl::Extctrls::TTimer* Timer1;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBPosChange(System::TObject* Sender);
	void __fastcall ECustLeftChange(System::TObject* Sender);
	void __fastcall CBCustPosClick(System::TObject* Sender);
	void __fastcall ECustTopChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall EXChange(System::TObject* Sender);
	void __fastcall EYChange(System::TObject* Sender);
	void __fastcall EZChange(System::TObject* Sender);
	void __fastcall EArrowDistChange(System::TObject* Sender);
	void __fastcall CBHeadChange(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall CBUnitsChange(System::TObject* Sender);
	void __fastcall CBAutoSizeClick(System::TObject* Sender);
	void __fastcall ECustWidthChange(System::TObject* Sender);
	void __fastcall ECustHeightChange(System::TObject* Sender);
	void __fastcall CBDraw3DClick(System::TObject* Sender);
	void __fastcall EPosZChange(System::TObject* Sender);
	void __fastcall PageControl3Change(System::TObject* Sender);
	void __fastcall Timer1Timer(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	bool CreatingForm;
	Vcltee::Teetextshapeeditor::TTextShapeEditor* IShapeEditor;
	bool __fastcall CanChangePos();
	bool __fastcall CanChangeSize();
	void __fastcall EnableCustomPosition();
	void __fastcall EnableCustomSize();
	
protected:
	Vcltee::Teetools::TAnnotationTool* Tool;
	Vcl::Comctrls::TTabSheet* IMainTab;
	
public:
	bool HideTextTab;
	__classmethod TAnnotationToolEdit* __fastcall InsertForm(Vcltee::Teetools::TAnnotationTool* const Annotation, Vcl::Controls::TWinControl* const AParent, bool ShowPositionTab = false);
	void __fastcall RefreshControls(Vcltee::Teetools::TAnnotationTool* const ATool);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAnnotationToolEdit(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAnnotationToolEdit(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAnnotationToolEdit() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAnnotationToolEdit(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeanntooledit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEANNTOOLEDIT)
using namespace Vcltee::Teeanntooledit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeanntooleditHPP
