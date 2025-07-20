// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeColorPalette.pas' rev: 34.00 (Windows)

#ifndef TeecolorpaletteHPP
#define TeecolorpaletteHPP

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
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeDraw3D.hpp>
#include <VCLTee.TeeGDIPlus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teecolorpalette
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TColorPalette;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TColorPalette : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TTrackBar* TrackBar1;
	Vcltee::Teedraw3d::TDraw3D* ColorPalette;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* LabelRGB;
	Vcl::Stdctrls::TLabel* LabelHLS;
	Vcltee::Tecanvas::TButtonColor* ShapeColor;
	Vcl::Extctrls::TPanel* PanelOK;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TScrollBar* SBTransp;
	void __fastcall ColorPaletteMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall ColorPaletteAfterDraw(System::TObject* Sender);
	void __fastcall TrackBar1Change(System::TObject* Sender);
	void __fastcall ShapeColorClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall ColorPaletteMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall ColorPaletteMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SBTranspChange(System::TObject* Sender);
	
private:
	System::Classes::TNotifyEvent FOnCurrentChanged;
	System::Uitypes::TColor ICurrent;
	bool IDragging;
	bool ChangingCurrent;
	bool ColorPaletteOk;
	Vcltee::Tecanvas::TTeePen* CrossPen;
	System::Uitypes::TColor __fastcall ApplyAlpha(const System::Uitypes::TColor AColor);
	System::Types::TPoint __fastcall ColorPosition(const System::Uitypes::TColor AColor);
	void __fastcall DrawCross();
	bool __fastcall MouseUnderCurrent();
	void __fastcall SetCurrent(System::Uitypes::TColor AColor);
	void __fastcall SetShapeColor(const System::Uitypes::TColor AColor, bool SetTrackLum = false);
	
public:
	bool MouseOver;
	__classmethod System::Uitypes::TColor __fastcall Edit(System::Classes::TComponent* AOwner, const System::Uitypes::TColor AColor);
	System::Uitypes::TColor __fastcall Selected();
	__property System::Uitypes::TColor CurrentColor = {read=ICurrent, write=SetCurrent, nodefault};
	__property System::Classes::TNotifyEvent OnCurrentChanged = {read=FOnCurrentChanged, write=FOnCurrentChanged};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TColorPalette(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TColorPalette(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TColorPalette() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TColorPalette(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecolorpalette */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEECOLORPALETTE)
using namespace Teecolorpalette;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeecolorpaletteHPP
