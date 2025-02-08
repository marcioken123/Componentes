// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBaseShape.pas' rev: 31.00 (Windows)

#ifndef LmdbaseshapeHPP
#define LmdbaseshapeHPP

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
#include <LMDShadow.hpp>
#include <LMDShapeBase.hpp>
#include <LMDBase.hpp>
#include <LMDGraph.hpp>
#include <LMDCaption.hpp>
#include <LMDShapeFill.hpp>
#include <LMDSimpleBevel.hpp>
#include <LMDPointList.hpp>
#include <LMDTeeth.hpp>
#include <LMDShape.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDClass.hpp>
#include <LMDTypes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbaseshape
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBaseShape;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDShapeControlMode : unsigned char { scmShapeFast, scmShapeFill, scmTeethFast, scmTeethFill };

class PASCALIMPLEMENTATION TLMDBaseShape : public Lmdbasegraphiccontrol::TLMDBaseGraphicControl
{
	typedef Lmdbasegraphiccontrol::TLMDBaseGraphicControl inherited;
	
private:
	Lmdsimplebevel::TLMDSimpleBevel* FBevel;
	Vcl::Graphics::TBrush* FBrush;
	System::Uitypes::TColor FBrushBackColor;
	Lmdcaption::TLMDCaption* FCaption;
	bool FCaptionClip;
	Lmdpointlist::TLMDPointList* FList;
	Lmdtypes::TLMDPercent FRoundPercent;
	Lmdshadow::TLMDShadow* FShadow;
	Lmdshape::TLMDShapeType FShape;
	bool FSquare;
	Lmdteeth::TLMDTeeth* FTeeth;
	Lmdteeth::TLMDTeeth* FTPointer;
	TLMDShapeControlMode FMode;
	void __fastcall SetShapeFill(Lmdshapefill::TLMDShapeFill* aValue);
	void __fastcall SetMode(TLMDShapeControlMode aValue);
	void __fastcall SetBevel(Lmdsimplebevel::TLMDSimpleBevel* aValue);
	void __fastcall SetBrush(Vcl::Graphics::TBrush* aValue);
	void __fastcall SetBrushBackColor(System::Uitypes::TColor aValue);
	void __fastcall SetCaption(Lmdcaption::TLMDCaption* aValue);
	void __fastcall SetCaptionClip(bool aValue);
	void __fastcall SetRoundPercent(Lmdtypes::TLMDPercent aValue);
	void __fastcall SetShadow(Lmdshadow::TLMDShadow* aValue);
	void __fastcall SetShape(Lmdshape::TLMDShapeType aValue);
	void __fastcall SetSquare(bool aValue);
	void __fastcall SetTeeth(Lmdteeth::TLMDTeeth* aValue);
	
protected:
	bool FChange;
	Lmdshapefill::TLMDShapeFill* FShapeFill;
	Vcl::Graphics::TBitmap* FCacheBitmap;
	void __fastcall GetShapeChange(void);
	void __fastcall OffscreenPaint(void);
	virtual void __fastcall BoundsChange(Lmdclass::TLMDBoundsChangeStates State);
	virtual void __fastcall DrawCaption(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual System::Types::TRect __fastcall GetGradientRect(void);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	virtual System::UnicodeString __fastcall GetLabelText(void);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	void __fastcall PaintToCanvas(Vcl::Graphics::TCanvas* aCanvas);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDBaseShape(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDBaseShape(void);
	void __fastcall SaveToFile(const System::UnicodeString Filename);
	__property TLMDShapeControlMode Mode = {read=FMode, write=SetMode, default=0};
	__property Lmdteeth::TLMDTeeth* Teeth = {read=FTeeth, write=SetTeeth};
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Lmdsimplebevel::TLMDSimpleBevel* Bevel = {read=FBevel, write=SetBevel};
	__property Vcl::Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property System::Uitypes::TColor BrushBackColor = {read=FBrushBackColor, write=SetBrushBackColor, default=-16777201};
	__property Lmdcaption::TLMDCaption* Caption = {read=FCaption, write=SetCaption};
	__property bool CaptionClip = {read=FCaptionClip, write=SetCaptionClip, default=0};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property Lmdtypes::TLMDPercent RoundPercent = {read=FRoundPercent, write=SetRoundPercent, default=33};
	__property Lmdshadow::TLMDShadow* Shadow = {read=FShadow, write=SetShadow};
	__property Lmdshape::TLMDShapeType Shape = {read=FShape, write=SetShape, default=1};
	__property ShowHint;
	__property bool Square = {read=FSquare, write=SetSquare, default=0};
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
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
	__property Lmdshapefill::TLMDShapeFill* ShapeFill = {read=FShapeFill, write=SetShapeFill};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbaseshape */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBASESHAPE)
using namespace Lmdbaseshape;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbaseshapeHPP
