// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomLight.pas' rev: 31.00 (Windows)

#ifndef LmdcustomlightHPP
#define LmdcustomlightHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDSimpleBevel.hpp>
#include <LMDCaption.hpp>
#include <LMDGraph.hpp>
#include <LMDPointList.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomlight
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomLight;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDLightStyle : unsigned char { ltRect, ltRound };

class PASCALIMPLEMENTATION TLMDCustomLight : public Lmdbasegraphiccontrol::TLMDBaseGraphicControl
{
	typedef Lmdbasegraphiccontrol::TLMDBaseGraphicControl inherited;
	
private:
	bool FActive;
	Lmdsimplebevel::TLMDSimpleBevel* FBevel;
	Lmdgraph::TLMDLightColor FColor;
	bool FDraw;
	System::Uitypes::TColor FOnColor;
	System::Uitypes::TColor FOffColor;
	Lmdpointlist::TLMDPointList* FList;
	TLMDLightStyle FStyle;
	
protected:
	virtual void __fastcall BoundsChange(Lmdclass::TLMDBoundsChangeStates State);
	void __fastcall Draw(bool PaintBorder);
	virtual void __fastcall GetChange(System::TObject* Sender);
	void __fastcall SetActive(bool aValue);
	void __fastcall SetBevel(Lmdsimplebevel::TLMDSimpleBevel* aValue);
	void __fastcall SetDraw(bool aValue);
	void __fastcall SetLightColor(Lmdgraph::TLMDLightColor aValue);
	void __fastcall SetStyle(TLMDLightStyle aValue);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDCustomLight(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomLight(void);
	__property bool Active = {read=FActive, write=SetActive, default=0};
	
__published:
	__property About = {default=0};
	__property Lmdsimplebevel::TLMDSimpleBevel* Bevel = {read=FBevel, write=SetBevel};
	__property Color = {default=-16777211};
	__property bool DrawExtended = {read=FDraw, write=SetDraw, default=0};
	__property Enabled = {default=1};
	__property Lmdgraph::TLMDLightColor LightColor = {read=FColor, write=SetLightColor, default=2};
	__property ParentColor = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TLMDLightStyle Style = {read=FStyle, write=SetStyle, default=1};
	__property Transparent = {default=1};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomlight */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMLIGHT)
using namespace Lmdcustomlight;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomlightHPP
