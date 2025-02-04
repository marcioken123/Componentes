// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sUpDown.pas' rev: 27.00 (Windows)

#ifndef SupdownHPP
#define SupdownHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sDefaults.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Supdown
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TsDrawingState : unsigned char { dsDefault, dsPrevUp, dsNextUp, dsPrevDown, dsNextDown };

class DELPHICLASS TsUpDown;
class PASCALIMPLEMENTATION TsUpDown : public Vcl::Comctrls::TCustomUpDown
{
	typedef Vcl::Comctrls::TCustomUpDown inherited;
	
private:
	bool FShowInaccessibility;
	Sconst::TsDisabledKind FDisabledKind;
	TsDrawingState FDrawingState;
	System::UnicodeString FButtonSkin;
	void __fastcall SetShowInaccessibility(const bool Value);
	void __fastcall SetDisabledKind(const Sconst::TsDisabledKind Value);
	void __fastcall SetDrawingState(const TsDrawingState Value);
	void __fastcall SetSkinSection(const System::UnicodeString Value);
	
protected:
	bool Pressed;
	System::Types::TRect __fastcall BtnRect(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	void __fastcall DrawBtn(Vcl::Graphics::TBitmap* Btn, Sconst::TacSide Side);
	__fastcall virtual TsUpDown(System::Classes::TComponent* AOwner);
	__property TsDrawingState DrawingState = {read=FDrawingState, write=SetDrawingState, default=0};
	
__published:
	__property Align = {default=0};
	__property AlignButton = {default=1};
	__property Anchors = {default=3};
	__property Associate;
	__property ArrowKeys = {default=1};
	__property Enabled = {default=1};
	__property Hint = {default=0};
	__property Min = {default=0};
	__property Max = {default=100};
	__property Increment = {default=1};
	__property Constraints;
	__property Orientation = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property Position = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Thousands = {default=1};
	__property Visible = {default=1};
	__property Wrap = {default=0};
	__property OnChanging;
	__property OnChangingEx;
	__property OnContextPopup;
	__property OnClick;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property System::UnicodeString ButtonSkin = {read=FButtonSkin, write=SetSkinSection};
	__property Sconst::TsDisabledKind DisabledKind = {read=FDisabledKind, write=SetDisabledKind, default=1};
	__property bool ShowInaccessibility = {read=FShowInaccessibility, write=SetShowInaccessibility, default=1};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsUpDown(HWND ParentWindow) : Vcl::Comctrls::TCustomUpDown(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TsUpDown(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Supdown */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SUPDOWN)
using namespace Supdown;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SupdownHPP
