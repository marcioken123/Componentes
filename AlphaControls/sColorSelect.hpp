// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sColorSelect.pas' rev: 27.00 (Windows)

#ifndef ScolorselectHPP
#define ScolorselectHPP

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
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <sSpeedButton.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Scolorselect
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsColorSelect;
class PASCALIMPLEMENTATION TsColorSelect : public Sspeedbutton::TsSpeedButton
{
	typedef Sspeedbutton::TsSpeedButton inherited;
	
private:
	System::Uitypes::TColor FColorValue;
	System::Classes::TNotifyEvent FOnChange;
	int FImgWidth;
	int FImgHeight;
	bool FStandardDlg;
	void __fastcall SetColorValue(const System::Uitypes::TColor Value);
	void __fastcall SetImgHeight(const int Value);
	void __fastcall SetImgWidth(const int Value);
	
protected:
	virtual bool __fastcall GetGrayed(void);
	
public:
	Vcl::Dialogs::TColorDialog* ColorDialog;
	virtual void __fastcall AfterConstruction(void);
	__fastcall virtual TsColorSelect(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	void __fastcall UpdateGlyph(bool Repaint = true);
	
__published:
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property System::Uitypes::TColor ColorValue = {read=FColorValue, write=SetColorValue, nodefault};
	__property int ImgWidth = {read=FImgWidth, write=SetImgWidth, default=15};
	__property int ImgHeight = {read=FImgHeight, write=SetImgHeight, default=15};
	__property bool StandardDlg = {read=FStandardDlg, write=FStandardDlg, default=0};
public:
	/* TsSpeedButton.Destroy */ inline __fastcall virtual ~TsColorSelect(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Scolorselect */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SCOLORSELECT)
using namespace Scolorselect;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ScolorselectHPP
