// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDColorEdit.pas' rev: 31.00 (Windows)

#ifndef LmdcoloreditHPP
#define LmdcoloreditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Types.hpp>
#include <LMDClass.hpp>
#include <LMDCustomBrowseEdit.hpp>
#include <LMDCustomControl.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.UITypes.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcoloredit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDColorEdit;
class DELPHICLASS TLMDLabeledColorEdit;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDColorEditPaint : unsigned char { ceText, ceColoredText, ceTextColor, ceColorText, ceColor };

class PASCALIMPLEMENTATION TLMDColorEdit : public Lmdcustombrowseedit::TLMDCustomBrowseEdit
{
	typedef Lmdcustombrowseedit::TLMDCustomBrowseEdit inherited;
	
private:
	Vcl::Dialogs::TColorDialogOptions FOptions;
	System::Classes::TStrings* FCustomColors;
	TLMDColorEditPaint FPaint;
	int FColorBarHeight;
	int FColorBarWidth;
	void __fastcall SetCustomColors(System::Classes::TStrings* aValue);
	void __fastcall SetPaintStyle(TLMDColorEditPaint aValue);
	HIDESBASE void __fastcall SetInteger(int index, int aValue);
	System::Uitypes::TColor __fastcall GetSelColor(void);
	HIDESBASE void __fastcall SetColor(System::Uitypes::TColor aValue);
	
protected:
	virtual void __fastcall DoBrowse(void);
	virtual void __fastcall DrawThemeBevel(Lmdclass::TLMDThemeMode aTheme, Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect);
	virtual void __fastcall DrawEditText(int from)/* overload */;
	virtual void __fastcall ModifyTextRect(void);
	
public:
	__fastcall virtual TLMDColorEdit(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDColorEdit(void);
	
__published:
	__property Vcl::Dialogs::TColorDialogOptions Options = {read=FOptions, write=FOptions, default=0};
	__property System::Classes::TStrings* CustomColors = {read=FCustomColors, write=SetCustomColors};
	__property int ColorBarWidth = {read=FColorBarWidth, write=SetInteger, index=0, default=30};
	__property int ColorBarHeight = {read=FColorBarHeight, write=SetInteger, index=1, default=-1};
	__property TLMDColorEditPaint PaintStyle = {read=FPaint, write=SetPaintStyle, default=0};
	__property System::Uitypes::TColor SelectedColor = {read=GetSelColor, write=SetColor, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDColorEdit(HWND ParentWindow) : Lmdcustombrowseedit::TLMDCustomBrowseEdit(ParentWindow) { }
	
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  DrawEditText(int from, const Lmdtypes::TLMDString aTxt){ Lmdcustomedit::TLMDCustomEdit::DrawEditText(from, aTxt); }
	
};


class PASCALIMPLEMENTATION TLMDLabeledColorEdit : public TLMDColorEdit
{
	typedef TLMDColorEdit inherited;
	
public:
	__fastcall virtual TLMDLabeledColorEdit(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDColorEdit.Destroy */ inline __fastcall virtual ~TLMDLabeledColorEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledColorEdit(HWND ParentWindow) : TLMDColorEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcoloredit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCOLOREDIT)
using namespace Lmdcoloredit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcoloreditHPP
