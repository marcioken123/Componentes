// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomProgress.pas' rev: 31.00 (Windows)

#ifndef LmdcustomprogressHPP
#define LmdcustomprogressHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <LMDGraph.hpp>
#include <LMDSmallBar.hpp>
#include <LMDBaseMeter.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <LMDGraphicControl.hpp>
#include <LMD3DCaption.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomprogress
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomProgress;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDProgressStyle : unsigned char { pgBar, pgSmallBar, pgSmallBarColor, pgOwnerDraw, pgXPBar };

typedef void __fastcall (__closure *TLMDProgressPaintEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &dest, const System::Types::TRect &notDest, const System::Types::TRect &aRect);

typedef void __fastcall (__closure *TLMDProgressColorEvent)(System::TObject* Sender, System::Byte nr, System::Uitypes::TColor &aColor);

class PASCALIMPLEMENTATION TLMDCustomProgress : public Lmdbasemeter::TLMDBaseMeter
{
	typedef Lmdbasemeter::TLMDBaseMeter inherited;
	
private:
	System::Uitypes::TColor FBarColor;
	Lmdgraph::TLMDBorderStyle FBar3D;
	Lmdsmallbar::TLMDSmallBar* FSmBar;
	TLMDProgressStyle FStyle;
	TLMDProgressPaintEvent FOnPaint;
	TLMDProgressColorEvent FOnColor;
	void __fastcall SetBarColor(System::Uitypes::TColor aColor);
	void __fastcall SetBar3D(Lmdgraph::TLMDBorderStyle aValue);
	void __fastcall SetSmBarOptions(Lmdsmallbar::TLMDSmallBar* aValue);
	void __fastcall SetStyle(TLMDProgressStyle aValue);
	
protected:
	virtual bool __fastcall CorrectBounds(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DrawBar(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &dest, const System::Types::TRect &notDest, const System::Types::TRect &aRect);
	virtual void __fastcall GetChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDCustomProgress(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomProgress(void);
	__property CtlXP = {default=0};
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Alignment = {default=2};
	__property System::Uitypes::TColor BarColor = {read=FBarColor, write=SetBarColor, default=8388608};
	__property Lmdgraph::TLMDBorderStyle Bar3D = {read=FBar3D, write=SetBar3D, default=0};
	__property Bevel;
	__property Delta = {default=1};
	__property Color = {default=-16777211};
	__property Caption = {default=0};
	__property Direction = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Font3D;
	__property MaxValue = {default=100};
	__property MinValue = {default=0};
	__property OptionsText = {default=0};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Lmdsmallbar::TLMDSmallBar* SmallBar = {read=FSmBar, write=SetSmBarOptions};
	__property TLMDProgressStyle Style = {read=FStyle, write=SetStyle, default=1};
	__property ThemeMode = {default=0};
	__property ThemeGlobalMode = {default=0};
	__property UseFontColor = {default=0};
	__property Visible = {default=1};
	__property TLMDProgressColorEvent OnGetColor = {read=FOnColor, write=FOnColor};
	__property TLMDProgressPaintEvent OnPaint = {read=FOnPaint, write=FOnPaint};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property DragKind = {default=0};
	__property Constraints;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomprogress */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMPROGRESS)
using namespace Lmdcustomprogress;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomprogressHPP
