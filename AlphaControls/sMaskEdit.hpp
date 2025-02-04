// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sMaskEdit.pas' rev: 27.00 (Windows)

#ifndef SmaskeditHPP
#define SmaskeditHPP

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
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sDefaults.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smaskedit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsMaskEdit;
class PASCALIMPLEMENTATION TsMaskEdit : public Vcl::Mask::TMaskEdit
{
	typedef Vcl::Mask::TMaskEdit inherited;
	
private:
	Scommondata::TsCtrlSkinData* FCommonData;
	Sconst::TsDisabledKind FDisabledKind;
	Scommondata::TsBoundLabel* FBoundLabel;
	void __fastcall SetDisabledKind(const Sconst::TsDisabledKind Value);
	
protected:
	virtual void __fastcall SetEditRect(void);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall PaintBorder(HDC DC);
	bool __fastcall PrepareCache(void);
	virtual void __fastcall PaintText(void);
	virtual void __fastcall OurPaintHandler(HDC aDC = (HDC)(0x0));
	void __fastcall ExcludeChildControls(HDC DC);
	HIDESBASE int __fastcall BorderWidth(void);
	
public:
	virtual void __fastcall AfterConstruction(void);
	__fastcall virtual TsMaskEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsMaskEdit(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
__published:
	__property Align = {default=0};
	__property Scommondata::TsBoundLabel* BoundLabel = {read=FBoundLabel, write=FBoundLabel};
	__property Sconst::TsDisabledKind DisabledKind = {read=FDisabledKind, write=SetDisabledKind, default=1};
	__property Scommondata::TsCtrlSkinData* SkinData = {read=FCommonData, write=FCommonData};
	__property OnMouseActivate;
	__property TextHint = {default=0};
	__property ParentDoubleBuffered = {default=1};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property Touch;
	__property OnGesture;
public:
	/* TWinControl.CreateParented */ inline __fastcall TsMaskEdit(HWND ParentWindow) : Vcl::Mask::TMaskEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Smaskedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SMASKEDIT)
using namespace Smaskedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SmaskeditHPP
