// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCalculator.pas' rev: 31.00 (Windows)

#ifndef LmdcalculatorHPP
#define LmdcalculatorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDButtonBase.hpp>
#include <LMDClass.hpp>
#include <LMDFXCaption.hpp>
#include <LMDButtonLayout.hpp>
#include <LMDGraph.hpp>
#include <LMDLabel.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDStack.hpp>
#include <LMDEmbeddedObject.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCalc.hpp>
#include <LMDControl.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDTypes.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDBevel.hpp>
#include <System.UITypes.hpp>
#include <LMDFillObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcalculator
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCalculator;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCalculator : public Lmdcalc::TLMDCustomCalculator
{
	typedef Lmdcalc::TLMDCustomCalculator inherited;
	
__published:
	__property About = {default=0};
	__property BackFX;
	__property Bevel;
	__property Color = {default=-16777201};
	__property ButtonStyle = {default=1};
	__property ThemeMode = {default=0};
	__property ThemeGlobalMode = {default=0};
	__property Decimals = {index=1, default=1};
	__property Precision = {index=2, default=15};
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property DisplaySettings;
	__property EditType = {default=1};
	__property BtnFont;
	__property FillObject;
	__property TabStop = {default=0};
	__property ParentBackground = {default=0};
	__property Transparent = {default=0};
	__property Visible = {default=1};
	__property Value = {default=0};
	__property OnCalc;
	__property OnWork;
	__property OnManualBtnSetup;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnStartDrag;
	__property OnDragDrop;
	__property OnClick;
	__property OnDblClick;
	__property OnEnter;
	__property OnExit;
	__property OnContextPopup;
	__property OnMouseActivate;
public:
	/* TLMDCustomCalculator.Create */ inline __fastcall virtual TLMDCalculator(System::Classes::TComponent* aOwner) : Lmdcalc::TLMDCustomCalculator(aOwner) { }
	/* TLMDCustomCalculator.Destroy */ inline __fastcall virtual ~TLMDCalculator(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCalculator(HWND ParentWindow) : Lmdcalc::TLMDCustomCalculator(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcalculator */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCALCULATOR)
using namespace Lmdcalculator;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcalculatorHPP
