// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRuler.pas' rev: 31.00 (Windows)

#ifndef LmdrulerHPP
#define LmdrulerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Forms.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdruler
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRuler;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDMeasureEvent)(System::TObject* Sender, int MeasureStart, int MeasureEnd, int Delta, bool IsHorzRuler);

enum DECLSPEC_DENUM TLMDAlignDir : unsigned char { adRulertoControl, adControltoRuler, adNone };

enum DECLSPEC_DENUM TLMDRulerOption : unsigned char { roUseTickColor, roRevertLabels, roRevertTicks, roNoSmallTicks };

typedef System::Set<TLMDRulerOption, TLMDRulerOption::roUseTickColor, TLMDRulerOption::roNoSmallTicks> TLMDRulerOptions;

class PASCALIMPLEMENTATION TLMDRuler : public Lmdcustompanel::TLMDCustomPanel
{
	typedef Lmdcustompanel::TLMDCustomPanel inherited;
	
private:
	Lmdgraph::TLMDBorderStyle FBorderStyle;
	TLMDAlignDir FCAlign;
	Vcl::Controls::TControl* FControl;
	int FScaleFactor;
	int FLeftMargin;
	int FRightMargin;
	int FLabelMargin;
	TLMDRulerOptions FOptions;
	int FLeftVal;
	int FRightVal;
	int FBigDist;
	int FNormalDist;
	int FSmallDist;
	System::Uitypes::TColor FBigColor;
	System::Uitypes::TColor FNormalColor;
	System::Uitypes::TColor FSmallColor;
	bool FIsPainting;
	bool FIsMeasuring;
	System::Types::TPoint FCurrentPos;
	bool FHorz;
	bool FPenVisible;
	int FMeasureEnd;
	int FMeasureStart;
	System::Uitypes::TColor FMeasureColor;
	System::Types::TRect FInternal;
	TLMDMeasureEvent FOnMeasure;
	void __fastcall SetAlignDir(TLMDAlignDir aDir);
	void __fastcall SetBorderStyle(Lmdgraph::TLMDBorderStyle aValue);
	HIDESBASE void __fastcall SetColor(int Index, System::Uitypes::TColor aColor);
	void __fastcall SetControl(Vcl::Controls::TControl* aControl);
	void __fastcall SetHorizontal(bool aValue);
	void __fastcall SetInteger(int Index, int aValue);
	void __fastcall SetOptions(TLMDRulerOptions aValue);
	bool __fastcall CheckRange(int x, int y);
	int __fastcall GetBevelExtend(void);
	HIDESBASE bool __fastcall HasControl(void);
	
protected:
	void __fastcall DrawPositionTick(Vcl::Graphics::TCanvas* ACanvas, int ax, int ay);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	__property bool PenVisible = {read=FPenVisible, write=FPenVisible, nodefault};
	
public:
	virtual void __fastcall DefaultHandler(void *Message);
	__fastcall virtual TLMDRuler(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDRuler(void);
	void __fastcall DoControlResize(void);
	void __fastcall DrawTick(int ax, int ay);
	void __fastcall DrawNotTick(void);
	void __fastcall BeginMeasure(int ax, int ay);
	void __fastcall Measure(int ax, int ay);
	void __fastcall EndMeasure(void);
	__property int MeasureStart = {read=FMeasureStart, nodefault};
	__property int BevelExtend = {read=GetBevelExtend, nodefault};
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Color = {default=-16777201};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentColor = {default=0};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TLMDAlignDir AlignControl = {read=FCAlign, write=SetAlignDir, default=2};
	__property int BigDist = {read=FBigDist, write=SetInteger, index=0, default=50};
	__property System::Uitypes::TColor BigColor = {read=FBigColor, write=SetColor, index=0, default=0};
	__property Lmdgraph::TLMDBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=2};
	__property Vcl::Controls::TControl* Control = {read=FControl, write=SetControl, stored=HasControl};
	__property bool Horizontal = {read=FHorz, write=SetHorizontal, default=1};
	__property int LabelMargin = {read=FLabelMargin, write=SetInteger, index=8, default=1};
	__property int LeftMargin = {read=FLeftMargin, write=SetInteger, index=3, default=0};
	__property int LeftVal = {read=FLeftVal, write=SetInteger, index=6, default=0};
	__property System::Uitypes::TColor MeasureColor = {read=FMeasureColor, write=FMeasureColor, default=8388608};
	__property int NormalDist = {read=FNormalDist, write=SetInteger, index=1, default=10};
	__property System::Uitypes::TColor NormalColor = {read=FNormalColor, write=SetColor, index=1, default=0};
	__property TLMDRulerOptions Options = {read=FOptions, write=SetOptions, default=0};
	__property int RightMargin = {read=FRightMargin, write=SetInteger, index=4, default=0};
	__property int RightVal = {read=FRightVal, write=SetInteger, index=7, default=1000};
	__property int ScaleFactor = {read=FScaleFactor, write=SetInteger, index=5, default=1};
	__property int SmallDist = {read=FSmallDist, write=SetInteger, index=2, default=5};
	__property System::Uitypes::TColor SmallColor = {read=FSmallColor, write=SetColor, index=2, default=0};
	__property TLMDMeasureEvent OnMeasure = {read=FOnMeasure, write=FOnMeasure};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRuler(HWND ParentWindow) : Lmdcustompanel::TLMDCustomPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdruler */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRULER)
using namespace Lmdruler;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrulerHPP
