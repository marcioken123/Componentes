// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeContourEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecontoureditHPP
#define Vcltee_TeecontoureditHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecontouredit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TContourSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TContourSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TCheckBox* CBAutoLevels;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* SENum;
	Vcl::Comctrls::TUpDown* UDNum;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Extctrls::TShape* SHColor;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* ELevel;
	Vcl::Comctrls::TUpDown* UDLevel;
	Vcl::Stdctrls::TEdit* EValue;
	Vcltee::Teependlg::TButtonPen* BLevelPen;
	Vcl::Stdctrls::TCheckBox* cbDefaultPen;
	Vcl::Stdctrls::TCheckBox* CBColorEach;
	Vcl::Stdctrls::TCheckBox* CBSmooth;
	Vcl::Stdctrls::TCheckBox* CBInterpolate;
	Vcl::Stdctrls::TCheckBox* CBFill;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Stdctrls::TCheckBox* CBMarksSegments;
	Vcl::Stdctrls::TCheckBox* CBMarksColor;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcltee::Tecanvas::TButtonColor* BMarksColor;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Stdctrls::TEdit* Edit2;
	Vcl::Comctrls::TUpDown* UDDensity;
	Vcl::Comctrls::TUpDown* UDMargin;
	Vcl::Stdctrls::TCheckBox* CBMarks;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Comctrls::TTabSheet* TabPointer;
	Vcl::Stdctrls::TCheckBox* CBEmpty;
	Vcl::Stdctrls::TScrollBar* SBLevel;
	Vcl::Comctrls::TTabSheet* TabSheet4;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* SEYPos;
	Vcl::Stdctrls::TCheckBox* CBYPosLevel;
	Vcl::Stdctrls::TCheckBox* CBBottom;
	Vcl::Stdctrls::TCheckBox* CBOverlap;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TEdit* EText;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TLabel* LSegmentCount;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabFrame;
	Vcl::Comctrls::TTabSheet* TabCellsPen;
	Vcl::Comctrls::TTrackBar* TBTransp;
	Vcl::Buttons::TSpeedButton* SBAdd;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall SENumChange(System::TObject* Sender);
	void __fastcall CBYPosLevelClick(System::TObject* Sender);
	void __fastcall SEYPosChange(System::TObject* Sender);
	void __fastcall CBColorEachClick(System::TObject* Sender);
	void __fastcall CBAutoLevelsClick(System::TObject* Sender);
	void __fastcall SHColorMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall ELevelChange(System::TObject* Sender);
	void __fastcall EValueChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall BLevelPenClick(System::TObject* Sender);
	void __fastcall cbDefaultPenClick(System::TObject* Sender);
	void __fastcall CBSmoothClick(System::TObject* Sender);
	void __fastcall CBInterpolateClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CBFillClick(System::TObject* Sender);
	void __fastcall CBMarksColorClick(System::TObject* Sender);
	void __fastcall CBMarksSegmentsClick(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall Edit2Change(System::TObject* Sender);
	void __fastcall CBMarksClick(System::TObject* Sender);
	void __fastcall CBEmptyClick(System::TObject* Sender);
	void __fastcall SBLevelChange(System::TObject* Sender);
	void __fastcall CBBottomClick(System::TObject* Sender);
	void __fastcall CBOverlapClick(System::TObject* Sender);
	void __fastcall ETextChange(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall SBAddClick(System::TObject* Sender);
	
private:
	Vcltee::Teesurfa::TContourSeries* Contour;
	bool CreatingForm;
	Vcl::Forms::TCustomForm* Grid3DForm;
	void __fastcall CheckBottom();
	void __fastcall DoCreateAutoLevels();
	Vcltee::Teesurfa::TContourLevel* __fastcall Level();
	void __fastcall SetLevel();
	System::Uitypes::TColor __fastcall VisualColor();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TContourSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TContourSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TContourSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TContourSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecontouredit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECONTOUREDIT)
using namespace Vcltee::Teecontouredit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecontoureditHPP
