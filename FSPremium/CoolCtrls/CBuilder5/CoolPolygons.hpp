// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolPolygons.pas' rev: 5.00

#ifndef CoolPolygonsHPP
#define CoolPolygonsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <CoolLists.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <CoolCtrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Coolpolygons
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TPointPosition { ptOnHandle, ptOnSide, ptNowhere };
#pragma option pop

typedef void __fastcall (__closure *TPolygonEvent)(System::TObject* Sender, int Index, const Windows::TPoint 
	&Pt);

class DELPHICLASS TSinglePolygon;
class PASCALIMPLEMENTATION TSinglePolygon : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Graphics::TColor FColor;
	Graphics::TColor FLineColor;
	Graphics::TColor FHandleColor;
	bool FTransparent;
	bool FTransparentEdges;
	Coollists::TPointList* FPoints;
	void __fastcall SetPoints(Coollists::TPointList* Value);
	void __fastcall SetTransparent(bool Value);
	void __fastcall SetTransparentEdges(bool Value);
	void __fastcall SetColor(Graphics::TColor Value);
	void __fastcall SetLineColor(Graphics::TColor Value);
	void __fastcall SetHandleColor(Graphics::TColor Value);
	void __fastcall PaintPolygon(Graphics::TCanvas* Canvas);
	bool __fastcall PointOnSide(Windows::TPoint &PointActive, Windows::TPoint &PointBefore, Windows::TPoint 
		&PointAfter);
	bool __fastcall PointOnHandle(Windows::TPoint &PointActive, Windows::TPoint &PointBefore, Windows::TPoint 
		&PointAfter);
	void __fastcall PointsChange(System::TObject* Sender);
	
protected:
	virtual AnsiString __fastcall GetDisplayName();
	
public:
	__fastcall virtual TSinglePolygon(Classes::TCollection* Collection)/* overload */;
	__fastcall virtual TSinglePolygon(Classes::TCollection* ACollection, Graphics::TColor AColor, Graphics::TColor 
		ALineColor, Graphics::TColor AHandleColor, Coollists::TPointList* APoints, bool ATransparent)/* overload */
		;
	__fastcall virtual ~TSinglePolygon(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	bool __fastcall PointWithinPolygon(const Windows::TPoint &PointActive);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-2147483633};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, default=0};
	__property Graphics::TColor HandleColor = {read=FHandleColor, write=SetHandleColor, default=0};
	__property Coollists::TPointList* Points = {read=FPoints, write=SetPoints};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool TransparentEdges = {read=FTransparentEdges, write=SetTransparentEdges, default=0};
};


class DELPHICLASS TPolygones;
class PASCALIMPLEMENTATION TPolygones : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
private:
	Classes::TComponent* FComp;
	HIDESBASE TSinglePolygon* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TSinglePolygon* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	__fastcall TPolygones(Classes::TComponent* Comp);
	HIDESBASE TSinglePolygon* __fastcall Add(Graphics::TColor AColor, Graphics::TColor ALineColor, Graphics::TColor 
		AHandleColor, Coollists::TPointList* APoints, bool ATransparent);
	__property TSinglePolygon* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TPolygones(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TEditModes { emAllowAddPolygone, emAllowAddHandle, emAllowResize };
#pragma option pop

typedef Set<TEditModes, emAllowAddPolygone, emAllowResize>  TEditMode;

class DELPHICLASS TCustomPolygones;
class PASCALIMPLEMENTATION TCustomPolygones : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	Graphics::TColor FDefColor;
	Graphics::TColor FDefEditLineColor;
	Graphics::TColor FDefEditHandleColor;
	Graphics::TColor FDefNormalLineColor;
	Graphics::TColor FDefNormalHandleColor;
	Coollists::TPointList* FPoints;
	TPolygones* FPolygones;
	Windows::TPoint FActivePoint;
	Windows::TPoint FPrevPoint;
	Windows::TPoint FNextPoint;
	TPointPosition FPointPosition;
	int FPolygonIndex;
	bool FTransparent;
	bool FEditable;
	TEditMode FEditMode;
	bool FPaintBorders;
	int FHandleSize;
	TPolygonEvent FOnPolygonMove;
	TPolygonEvent FOnPolygonClick;
	void __fastcall PaintPolygones(Graphics::TCanvas* Canv);
	void __fastcall PaintPoints(Graphics::TCanvas* Canv);
	void __fastcall PaintEditHandle(Graphics::TCanvas* Canv, const Windows::TPoint &Pt);
	void __fastcall SetHandleSize(int Value);
	void __fastcall SetPoints(Coollists::TPointList* Value);
	void __fastcall SetTransparent(bool Value);
	void __fastcall SetPaintBorders(bool Value);
	
protected:
	virtual void __fastcall PointsChange(System::TObject* Sender);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int 
		Y);
	virtual void __fastcall Paint(void);
	virtual void __fastcall FastRepaint(void);
	
public:
	__fastcall virtual TCustomPolygones(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomPolygones(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Graphics::TColor DefColor = {read=FDefColor, write=FDefColor, default=-2147483633};
	__property Graphics::TColor DefEditLineColor = {read=FDefEditLineColor, write=FDefEditLineColor, default=255
		};
	__property Graphics::TColor DefEditHandleColor = {read=FDefEditHandleColor, write=FDefEditHandleColor
		, default=255};
	__property Graphics::TColor DefNormalLineColor = {read=FDefNormalLineColor, write=FDefNormalLineColor
		, default=0};
	__property Graphics::TColor DefNormalHandleColor = {read=FDefNormalHandleColor, write=FDefNormalHandleColor
		, default=0};
	__property bool Editable = {read=FEditable, write=FEditable, default=1};
	__property TEditMode EditMode = {read=FEditMode, write=FEditMode, default=7};
	__property int HandleSize = {read=FHandleSize, write=SetHandleSize, default=3};
	__property bool PaintBorders = {read=FPaintBorders, write=SetPaintBorders, default=0};
	__property Coollists::TPointList* Points = {read=FPoints, write=SetPoints};
	__property TPointPosition PointPosition = {read=FPointPosition, nodefault};
	__property TPolygones* Polygones = {read=FPolygones, write=FPolygones};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property TPolygonEvent OnPolygonClick = {read=FOnPolygonClick, write=FOnPolygonClick};
	__property TPolygonEvent OnPolygonMove = {read=FOnPolygonMove, write=FOnPolygonMove};
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
};


class DELPHICLASS TCoolPolygones;
class PASCALIMPLEMENTATION TCoolPolygones : public TCustomPolygones 
{
	typedef TCustomPolygones inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Message);
	
__published:
	__property Color ;
	__property DefColor ;
	__property DefEditLineColor ;
	__property DefEditHandleColor ;
	__property DefNormalLineColor ;
	__property DefNormalHandleColor ;
	__property Editable ;
	__property EditMode ;
	__property HandleSize ;
	__property ParentColor ;
	__property Points ;
	__property Polygones ;
	__property Transparent ;
	__property Align ;
	__property Cursor ;
	__property Visible ;
	__property OnMouseDown ;
	__property OnMouseUp ;
	__property OnMouseMove ;
	__property OnPolygonClick ;
	__property OnPolygonMove ;
public:
	#pragma option push -w-inl
	/* TCustomPolygones.Create */ inline __fastcall virtual TCoolPolygones(Classes::TComponent* AOwner)
		 : TCustomPolygones(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomPolygones.Destroy */ inline __fastcall virtual ~TCoolPolygones(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCoolPolyRegions;
class PASCALIMPLEMENTATION TCoolPolyRegions : public TCustomPolygones 
{
	typedef TCustomPolygones inherited;
	
private:
	bool FActive;
	void __fastcall SetPolyRegiones(void);
	void __fastcall SetActive(bool Value);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Message);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall ApplyPolygones(void);
	virtual void __fastcall PointsChange(System::TObject* Sender);
	
public:
	__fastcall virtual TCoolPolyRegions(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolPolyRegions(void);
	
__published:
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property DefColor ;
	__property DefEditLineColor ;
	__property DefEditHandleColor ;
	__property DefNormalLineColor ;
	__property DefNormalHandleColor ;
	__property Editable ;
	__property EditMode ;
	__property HandleSize ;
	__property Points ;
	__property Polygones ;
	__property Transparent ;
	__property Align ;
	__property Cursor ;
	__property Visible ;
	__property OnMouseDown ;
	__property OnMouseUp ;
	__property OnMouseMove ;
	__property OnPolygonClick ;
	__property OnPolygonMove ;
};


#pragma option push -b-
enum TColorsAction { caExclude, caInclude };
#pragma option pop

class DELPHICLASS TCoolImageShape;
class PASCALIMPLEMENTATION TCoolImageShape : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	HRGN FRgn;
	Coolctrls::TCCAboutBox* FAboutBox;
	bool FActive;
	Graphics::TBitmap* FBitmap;
	Coollists::TColorList* FColors;
	TColorsAction FColorsAction;
	bool FFastCreate;
	bool FMoveParent;
	Classes::TNotifyEvent FOnChangeState;
	void __fastcall SetActive(bool Value);
	void __fastcall SetBitmap(Graphics::TBitmap* Value);
	void __fastcall SetColors(Coollists::TColorList* Value);
	void __fastcall SetColorsAction(TColorsAction Value);
	void __fastcall BitmapChanged(System::TObject* Sender);
	HRGN __fastcall GetColorsRegion(void);
	void __fastcall SetColorsRegion(void);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	
protected:
	__property Align ;
	__property AutoSize ;
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	virtual bool __fastcall CanAutoSize(int &NewWidth, int &NewHeight);
	DYNAMIC void __fastcall ApplyRegions(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	
public:
	__fastcall virtual TCoolImageShape(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolImageShape(void);
	void __fastcall AdjustAppearance(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	__property Coollists::TColorList* Colors = {read=FColors, write=SetColors};
	__property TColorsAction ColorsAction = {read=FColorsAction, write=SetColorsAction, default=0};
	__property bool FastCreate = {read=FFastCreate, write=FFastCreate, default=0};
	__property bool MoveParent = {read=FMoveParent, write=FMoveParent, default=0};
	__property Classes::TNotifyEvent OnChangeState = {read=FOnChangeState, write=FOnChangeState};
	__property Anchors ;
	__property Constraints ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ShowHint ;
	__property Visible ;
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall ArrayFromList(Windows::TPoint * AArray, const int AArray_Size, Coollists::TPointList* 
	AList);
extern PACKAGE void __fastcall PolyRects(Graphics::TCanvas* Canvas, Coollists::TPointList* Points, int 
	Offset);
extern PACKAGE HRGN __fastcall RgnFromRects(Coollists::TRectList* Rects, int RWidth, int RHeight);

}	/* namespace Coolpolygons */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Coolpolygons;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolPolygons
