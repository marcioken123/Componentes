// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDAlignmentEditor.pas' rev: 31.00 (Windows)

#ifndef PlmdalignmenteditorHPP
#define PlmdalignmenteditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Buttons.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdalignmenteditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDAlignmentEditor;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDAlignmentMode : unsigned char { amAll, amBorder, am4Sides, am4SidesCenter };

class PASCALIMPLEMENTATION TLMDAlignmentEditor : public Vcl::Stdctrls::TCustomGroupBox
{
	typedef Vcl::Stdctrls::TCustomGroupBox inherited;
	
private:
	Vcl::Buttons::TSpeedButton* FBottomButton;
	Vcl::Buttons::TSpeedButton* FBottomLeftButton;
	Vcl::Buttons::TSpeedButton* FTopLeftButton;
	Vcl::Buttons::TSpeedButton* FBottomRightButton;
	Vcl::Buttons::TSpeedButton* FRightButton;
	Vcl::Buttons::TSpeedButton* FCenterButton;
	Vcl::Buttons::TSpeedButton* FTopButton;
	Vcl::Buttons::TSpeedButton* FTopRightButton;
	Vcl::Buttons::TSpeedButton* FLeftButton;
	int FButtonSpaceWidth;
	TLMDAlignmentMode FMode;
	System::Classes::TList* FButtonList;
	int FSelY;
	int FSelX;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall SetButtonSpaceWidth(const int Value);
	void __fastcall SetMode(const TLMDAlignmentMode Value);
	void __fastcall SetSelX(const int Value);
	void __fastcall SetSelY(const int Value);
	
protected:
	DYNAMIC void __fastcall Resize(void);
	void __fastcall ButtonClick(System::TObject* ASender);
	Vcl::Buttons::TSpeedButton* __fastcall GetPressedButton(void);
	int __fastcall GetButtonX(Vcl::Buttons::TSpeedButton* AButton);
	int __fastcall GetButtonY(Vcl::Buttons::TSpeedButton* AButton);
	void __fastcall SetButtonDown(Vcl::Buttons::TSpeedButton* AButton);
	
public:
	__fastcall virtual TLMDAlignmentEditor(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDAlignmentEditor(void);
	
__published:
	__property Vcl::Buttons::TSpeedButton* TopLeftButton = {read=FTopLeftButton};
	__property Vcl::Buttons::TSpeedButton* LeftButton = {read=FLeftButton};
	__property Vcl::Buttons::TSpeedButton* BottomLeftButton = {read=FBottomLeftButton};
	__property Vcl::Buttons::TSpeedButton* BottomButton = {read=FBottomButton};
	__property Vcl::Buttons::TSpeedButton* BottomRightButton = {read=FBottomRightButton};
	__property Vcl::Buttons::TSpeedButton* RightButton = {read=FRightButton};
	__property Vcl::Buttons::TSpeedButton* TopRightButton = {read=FTopRightButton};
	__property Vcl::Buttons::TSpeedButton* TopButton = {read=FTopButton};
	__property Vcl::Buttons::TSpeedButton* CenterButton = {read=FCenterButton};
	__property int ButtonSpaceWidth = {read=FButtonSpaceWidth, write=SetButtonSpaceWidth, nodefault};
	__property TLMDAlignmentMode Mode = {read=FMode, write=SetMode, nodefault};
	__property int SelX = {read=FSelX, write=SetSelX, nodefault};
	__property int SelY = {read=FSelY, write=SetSelY, nodefault};
	__property Caption = {default=0};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDAlignmentEditor(HWND ParentWindow) : Vcl::Stdctrls::TCustomGroupBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdalignmenteditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDALIGNMENTEDITOR)
using namespace Plmdalignmenteditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdalignmenteditorHPP
