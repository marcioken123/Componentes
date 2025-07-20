// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeArrowToolEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeearrowtooleditorHPP
#define Vcltee_TeearrowtooleditorHPP

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
#include <System.Types.hpp>
#include <VCLTee.TeeArrowTool.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teearrowtooleditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TArrowToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TArrowToolEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabPosition;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Comctrls::TTrackBar* TBWidth;
	Vcl::Comctrls::TTrackBar* TBHeight;
	Vcl::Comctrls::TTrackBar* TBPercent;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TEdit* EFromX;
	Vcl::Comctrls::TUpDown* UDFromX;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TEdit* EFromY;
	Vcl::Comctrls::TUpDown* UDFromY;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TEdit* EToX;
	Vcl::Comctrls::TUpDown* UDToX;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TEdit* EToY;
	Vcl::Comctrls::TUpDown* UDToY;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabPattern;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Comctrls::TTrackBar* TBAngle;
	Vcl::Stdctrls::TCheckBox* CBDraw2D;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Comctrls::TTrackBar* TBZ;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Comctrls::TTrackBar* TBTransp;
	Vcl::Stdctrls::TCheckBox* CBFilled;
	Vcl::Stdctrls::TCheckBox* CBRotateGradient;
	void __fastcall TBWidthChange(System::TObject* Sender);
	void __fastcall TBHeightChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBFilledClick(System::TObject* Sender);
	void __fastcall TBAngleChange(System::TObject* Sender);
	void __fastcall TBZChange(System::TObject* Sender);
	void __fastcall TBPercentChange(System::TObject* Sender);
	void __fastcall CBDraw2DClick(System::TObject* Sender);
	void __fastcall EFromXChange(System::TObject* Sender);
	void __fastcall EFromYChange(System::TObject* Sender);
	void __fastcall EToXChange(System::TObject* Sender);
	void __fastcall EToYChange(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall CBRotateGradientClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	Vcltee::Teearrowtool::TArrowTool* Arrow;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TArrowToolEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TArrowToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TArrowToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TArrowToolEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teearrowtooleditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEARROWTOOLEDITOR)
using namespace Vcltee::Teearrowtooleditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeearrowtooleditorHPP
