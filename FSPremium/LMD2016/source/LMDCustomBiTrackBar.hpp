// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomBiTrackBar.pas' rev: 31.00 (Windows)

#ifndef LmdcustombitrackbarHPP
#define LmdcustombitrackbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDProcs.hpp>
#include <LMDCustomTrackBar.hpp>
#include <LMDFillObject.hpp>
#include <LMDThemes.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustombitrackbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomBiTrackBar;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomBiTrackBar : public Lmdcustomtrackbar::TLMDCustomTrackBar
{
	typedef Lmdcustomtrackbar::TLMDCustomTrackBar inherited;
	
private:
	int FDiapasonVerticalMargin;
	void __fastcall SetLeftPosition(int Value);
	void __fastcall SetRightPosition(int Value);
	void __fastcall SetDiapasonPosition(const int Value);
	void __fastcall NormalizePosition(int &Value);
	void __fastcall SetDiapasonFillObject(Lmdfillobject::TLMDFillObject* const Value);
	void __fastcall SetDiapasonMargin(const int Value);
	
protected:
	int FRightPosition;
	int FLeftPosition;
	System::Types::TRect FLeftBRect;
	System::Types::TRect FRightBRect;
	Vcl::Graphics::TBitmap* FDiapasonBack;
	Vcl::Graphics::TBitmap* FLeftBack;
	Vcl::Graphics::TBitmap* FRightBack;
	bool FLeftSliding;
	bool FRightSliding;
	Lmdfillobject::TLMDFillObject* FDiapasonFillObject;
	System::Types::TRect FDiapasonRect;
	bool FDiapasonSliding;
	int FDiapasonLength;
	int FDiapasonPosition;
	int FLengthToLeft;
	virtual int __fastcall MousePosToThumbPos(int x, int y);
	virtual void __fastcall TimerExpired(System::TObject* Sender);
	virtual void __fastcall Paint(void);
	virtual void __fastcall DrawDiapason(void);
	virtual void __fastcall RestoreDiapasonBack(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int x, int y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int x, int y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual bool __fastcall SetScrolledPosition(int X, int Y);
	__property int DiapasonPosition = {read=FDiapasonPosition, write=SetDiapasonPosition, nodefault};
	
public:
	__fastcall virtual TLMDCustomBiTrackBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomBiTrackBar(void);
	__property int DiapasonMargin = {read=FDiapasonVerticalMargin, write=SetDiapasonMargin, default=3};
	__property Lmdfillobject::TLMDFillObject* DiapasonFillObject = {read=FDiapasonFillObject, write=SetDiapasonFillObject};
	__property int RightPosition = {read=FRightPosition, write=SetRightPosition, nodefault};
	__property int LeftPosition = {read=FLeftPosition, write=SetLeftPosition, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomBiTrackBar(HWND ParentWindow) : Lmdcustomtrackbar::TLMDCustomTrackBar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustombitrackbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMBITRACKBAR)
using namespace Lmdcustombitrackbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustombitrackbarHPP
