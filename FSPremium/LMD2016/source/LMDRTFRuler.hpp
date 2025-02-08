// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFRuler.pas' rev: 31.00 (Windows)

#ifndef LmdrtfrulerHPP
#define LmdrtfrulerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDRTFBase.hpp>
#include <LMDTypes.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfruler
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRTFRuler;
class DELPHICLASS TIndentImage;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDRTFRulerEvent)(System::TObject* Sender, int aPos);

enum DECLSPEC_DENUM TLMDRTFRulerMode : unsigned char { rmWithMargins, rmWithoutMargins };

class PASCALIMPLEMENTATION TLMDRTFRuler : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	TLMDRTFRulerMode FMode;
	bool FDragging;
	bool FDraggingLeft;
	bool FDraggingRight;
	int FDragOfs;
	TIndentImage* FImgFirstIndent;
	TIndentImage* FImgLeftIndent;
	TIndentImage* FImgRightIndent;
	TIndentImage* FImgBothLeftIndent;
	int FMarginRight;
	int FMarginLeft;
	Vcl::Stdctrls::TCustomMemo* FRichEdit;
	System::Classes::TList* FTabs;
	System::Types::TRect FEditRect;
	Lmdtypes::TLMDUnits FMeasurement;
	System::Types::TRect FHostRect;
	double FRulerTab;
	int FDist;
	int FFact;
	int FOffset;
	System::Uitypes::TColor FBackColor;
	System::Uitypes::TColor FMarginColor;
	Vcl::Controls::TControlCanvas* FControlCanvas;
	TLMDRTFRulerEvent FOnRulerTabCreate;
	TLMDRTFRulerEvent FOnRulerTabChange;
	TLMDRTFRulerEvent FOnRulerTabDestroy;
	TLMDRTFRulerEvent FOnRulerFirstIdentChange;
	TLMDRTFRulerEvent FOnRulerLeftIdentChange;
	TLMDRTFRulerEvent FOnRulerRightIdentChange;
	int __fastcall GetIndentFirst(void);
	int __fastcall GetIndentLeft(void);
	int __fastcall GetIndentRight(void);
	void __fastcall SetBackColor(const System::Uitypes::TColor Value);
	void __fastcall SetIndentFirst(const int Value);
	void __fastcall SetIndentLeft(const int Value);
	void __fastcall SetIndentRight(const int Value);
	void __fastcall SetMarginColor(const System::Uitypes::TColor Value);
	void __fastcall SetMarginLeft(const int Value);
	int __fastcall GetMarginLeft(void);
	int __fastcall GetMarginRight(void);
	void __fastcall SetMarginRight(const int Value);
	void __fastcall SetRichedit(Vcl::Stdctrls::TCustomMemo* const Value);
	void __fastcall SetMode(TLMDRTFRulerMode Value);
	void __fastcall SetMeasurement(Lmdtypes::TLMDUnits Value);
	void __fastcall SetHostRect(const System::Types::TRect &Value);
	int __fastcall GetRulerTabPos(int Pos, int Trend, int dx);
	void __fastcall SetOffset(int Value);
	void __fastcall SetIndentValue(TIndentImage* IndentImage, int Value);
	int __fastcall RightBound(void);
	int __fastcall GetIndentMarkerWidth(void);
	
protected:
	virtual void __fastcall RequestAlign(void);
	virtual void __fastcall AdjustClientRect(System::Types::TRect &Rect);
	void __fastcall DrawFocusLine(int x1, int y1, int x2, int y2);
	void __fastcall IndentMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall IndentMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall IndentMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall IndentPaint(System::TObject* Sender);
	void __fastcall TabMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall TabMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall TabMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall TabPaint(System::TObject* Sender);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall MoveFocusLine(int oldOfs, int newOfs);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	bool __fastcall CreateTab(int aPos);
	int __fastcall PageWidth(void);
	void __fastcall SetRichEditTabs(void);
	
public:
	__fastcall virtual TLMDRTFRuler(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDRTFRuler(void);
	void __fastcall CreateTabs(void);
	void __fastcall SetIndents(int Left, int First, int Right);
	__property TLMDRTFRulerMode Mode = {read=FMode, write=SetMode, nodefault};
	__property System::Types::TRect HostRect = {read=FHostRect, write=SetHostRect};
	__property int IndentMarkerWidth = {read=GetIndentMarkerWidth, nodefault};
	__property System::Types::TRect EditRect = {read=FEditRect};
	
__published:
	__property Color = {default=-16777211};
	__property System::Uitypes::TColor BackColor = {read=FBackColor, write=SetBackColor, default=-16777201};
	__property System::Uitypes::TColor MarginColor = {read=FMarginColor, write=SetMarginColor, default=-16777200};
	__property int IndentFirst = {read=GetIndentFirst, write=SetIndentFirst, nodefault};
	__property int IndentLeft = {read=GetIndentLeft, write=SetIndentLeft, nodefault};
	__property int IndentRight = {read=GetIndentRight, write=SetIndentRight, nodefault};
	__property int MarginLeft = {read=GetMarginLeft, write=SetMarginLeft, default=0};
	__property int MarginRight = {read=GetMarginRight, write=SetMarginRight, default=0};
	__property int Offset = {read=FOffset, write=SetOffset, default=0};
	__property Vcl::Stdctrls::TCustomMemo* RichEdit = {read=FRichEdit, write=SetRichedit};
	__property Lmdtypes::TLMDUnits Measurement = {read=FMeasurement, write=SetMeasurement, default=0};
	__property TLMDRTFRulerEvent OnRulerTabCreate = {read=FOnRulerTabCreate, write=FOnRulerTabCreate};
	__property TLMDRTFRulerEvent OnRulerTabChange = {read=FOnRulerTabChange, write=FOnRulerTabChange};
	__property TLMDRTFRulerEvent OnRulerTabDestroy = {read=FOnRulerTabDestroy, write=FOnRulerTabDestroy};
	__property TLMDRTFRulerEvent OnRulerFirstIdentChange = {read=FOnRulerFirstIdentChange, write=FOnRulerFirstIdentChange};
	__property TLMDRTFRulerEvent OnRulerLeftIdentChange = {read=FOnRulerLeftIdentChange, write=FOnRulerLeftIdentChange};
	__property TLMDRTFRulerEvent OnRulerRightIdentChange = {read=FOnRulerRightIdentChange, write=FOnRulerRightIdentChange};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRTFRuler(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TIndentID : unsigned char { riFirst, riLeft, riRight, riBothLeft };

class PASCALIMPLEMENTATION TIndentImage : public Vcl::Extctrls::TPaintBox
{
	typedef Vcl::Extctrls::TPaintBox inherited;
	
private:
	TIndentID FIndentID;
	bool FDragging;
	int FValue;
	void __fastcall SetIndentID(TIndentID Value);
	
public:
	__fastcall virtual TIndentImage(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TIndentImage(void);
	__property TIndentID IndentID = {read=FIndentID, write=SetIndentID, nodefault};
	__property int Value = {read=FValue, write=FValue, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 FBorderUp = System::Int8(0x5);
static const System::Int8 FBorderDown = System::Int8(0x5);
static const System::Int8 FBorderLeft = System::Int8(0x5);
static const System::Int8 FBorderRight = System::Int8(0x5);
static const System::Int8 DefTabSizePoints = System::Int8(0x24);
}	/* namespace Lmdrtfruler */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFRULER)
using namespace Lmdrtfruler;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfrulerHPP
