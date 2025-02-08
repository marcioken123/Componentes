// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFPrintPreviewMode.pas' rev: 31.00 (Windows)

#ifndef LmdrtfprintpreviewmodeHPP
#define LmdrtfprintpreviewmodeHPP

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
#include <Vcl.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfprintpreviewmode
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRTFPrintPreviewMode;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TRTFPrintPreviewMode : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel;
	Vcl::Extctrls::TImage* imSelected1;
	Vcl::Extctrls::TImage* imUnSelected1;
	Vcl::Extctrls::TImage* imSelected2;
	Vcl::Extctrls::TImage* imUnSelected2;
	Vcl::Extctrls::TImage* imSelected3;
	Vcl::Extctrls::TImage* imUnSelected3;
	Vcl::Extctrls::TImage* imSelected4;
	Vcl::Extctrls::TImage* imUnSelected4;
	Vcl::Extctrls::TImage* imSelected5;
	Vcl::Extctrls::TImage* imUnSelected5;
	Vcl::Extctrls::TImage* imSelected6;
	Vcl::Extctrls::TImage* imUnSelected6;
	Vcl::Stdctrls::TStaticText* Msg;
	void __fastcall MsgClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall MsgMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall imSelected1MouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall PanelMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall imSelected4Click(System::TObject* Sender);
	
private:
	int FRowCount;
	int FColCount;
	
public:
	__property int RowCount = {read=FRowCount, nodefault};
	__property int ColCount = {read=FColCount, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TRTFPrintPreviewMode(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRTFPrintPreviewMode(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRTFPrintPreviewMode(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRTFPrintPreviewMode(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtfprintpreviewmode */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFPRINTPREVIEWMODE)
using namespace Lmdrtfprintpreviewmode;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfprintpreviewmodeHPP
