// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sSplitter.pas' rev: 27.00 (Windows)

#ifndef SsplitterHPP
#define SsplitterHPP

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
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ssplitter
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsSplitter;
class PASCALIMPLEMENTATION TsSplitter : public Vcl::Extctrls::TSplitter
{
	typedef Vcl::Extctrls::TSplitter inherited;
	
private:
	Scommondata::TsCommonData* FCommonData;
	bool FSizing;
	System::Classes::TNotifyEvent FOnMouseLeave;
	System::Classes::TNotifyEvent FOnMouseEnter;
	Vcl::Graphics::TBitmap* FGlyph;
	bool FShowGrip;
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetShowGrip(const bool Value);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TsSplitter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsSplitter(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Loaded(void);
	
__published:
	__property Enabled = {default=1};
	__property Color = {default=-16777211};
	__property Vcl::Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property ParentColor = {default=1};
	__property Hint = {default=0};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property bool ShowGrip = {read=FShowGrip, write=SetShowGrip, default=0};
	__property Visible = {default=1};
	__property Width = {default=6};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property OnMouseUp;
	__property OnResize;
	__property Scommondata::TsCommonData* SkinData = {read=FCommonData, write=FCommonData};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Ssplitter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SSPLITTER)
using namespace Ssplitter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SsplitterHPP
