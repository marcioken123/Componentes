// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_ToolsHPP
#define Fmxtee_ToolsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Generics.Collections.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Graphics.hpp>
#include <System.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAnnotationCallout;
class DELPHICLASS TAnnotationTool;
class DELPHICLASS TCursorTool;
class DELPHICLASS TDragMarksTool;
class DELPHICLASS TAxisArrowTool;
class DELPHICLASS TScrollBarThumb;
class DELPHICLASS TTeeScrollBar;
class DELPHICLASS TAxisScrollBarTool;
class DELPHICLASS TAxisScrollTool;
class DELPHICLASS TDrawLine;
class DELPHICLASS TDrawLines;
class DELPHICLASS TDrawLineTool;
class DELPHICLASS TMarksTipTool;
class DELPHICLASS TNearestTool;
class DELPHICLASS TColorBandTool;
class DELPHICLASS TGridBandBrush;
class DELPHICLASS TGridBandTool;
class DELPHICLASS TColorLineTool;
class DELPHICLASS TRotateTool;
class DELPHICLASS TChartImageTool;
class DELPHICLASS TRectangleTool;
class DELPHICLASS TClipSeriesTool;
class DELPHICLASS TFullScreenTool;
class DELPHICLASS TRepaintMonitor;
class DELPHICLASS TTeeCombo;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TAnnotationPosition : unsigned char { ppLeftTop, ppLeftBottom, ppRightTop, ppRightBottom, ppCenter };

typedef void __fastcall (__closure *TAnnotationClick)(TAnnotationTool* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TAnnotationCallout : public Fmxtee::Engine::TCallout
{
	typedef Fmxtee::Engine::TCallout inherited;
	
private:
	int FX;
	int FY;
	int FZ;
	System::Types::TPointF __fastcall CloserPoint(const System::Types::TRectF &R, const System::Types::TPointF &P);
	void __fastcall SetX(const int Value);
	void __fastcall SetY(const int Value);
	void __fastcall SetZ(const int Value);
	
public:
	__fastcall TAnnotationCallout(Fmxtee::Engine::TChartSeries* const AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Visible = {default=0};
	__property int XPosition = {read=FX, write=SetX, default=0};
	__property int YPosition = {read=FY, write=SetY, default=0};
	__property int ZPosition = {read=FZ, write=SetZ, default=0};
public:
	/* TCallout.Destroy */ inline __fastcall virtual ~TAnnotationCallout() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TAnnotationTool : public Fmxtee::Engine::TTeeCustomTool
{
	typedef Fmxtee::Engine::TTeeCustomTool inherited;
	
private:
	TAnnotationCallout* FCallout;
	bool FDraw3D;
	System::Classes::TNotifyEvent FOnAfterDraw;
	System::Classes::TNotifyEvent FOnBeforeDraw;
	TAnnotationClick FOnClick;
	TAnnotationClick FOnDblClick;
	TAnnotationPosition FPosition;
	Fmxtee::Procs::TTeeUnits FPositionUnits;
	Fmxtee::Engine::TTeeSelected* FSelected;
	Fmxtee::Chart::TTextShape* FShape;
	int FZ;
	bool __fastcall GetAutoSize();
	System::Types::TRectF __fastcall GetBounds();
	System::Types::TRectF __fastcall GetBoundsParent(Fmxtee::Engine::TCustomAxisPanel* const AParent);
	bool __fastcall GetClipText();
	System::Uitypes::TCursor __fastcall GetCursor();
	int __fastcall GetHeight();
	int __fastcall GetLeft();
	System::Classes::TAlignment __fastcall GetTextAlign();
	int __fastcall GetTop();
	int __fastcall GetWidth();
	void __fastcall InternalSetParent(Fmxtee::Engine::TCustomAxisPanel* const Value);
	bool __fastcall IsNotAutoSize();
	HIDESBASE void __fastcall Repaint();
	void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetBounds(const System::Types::TRectF &Value);
	void __fastcall SetCallout(TAnnotationCallout* const Value);
	void __fastcall SetClipText(const bool Value);
	void __fastcall SetCursor(const System::Uitypes::TCursor Value);
	void __fastcall SetDraw3D(const bool Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetPosition(const TAnnotationPosition Value);
	void __fastcall SetPositionUnits(const Fmxtee::Procs::TTeeUnits Value);
	void __fastcall SetSelected(Fmxtee::Engine::TTeeSelected* const Value);
	void __fastcall SetShape(Fmxtee::Chart::TTextShape* const Value);
	void __fastcall SetTextAlign(const System::Classes::TAlignment Value);
	void __fastcall SetTop(const int Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetZ(const int Value);
	
protected:
	bool IKeepCursor;
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual Fmxtee::Chart::TTextShape* __fastcall CreateShape();
	virtual void __fastcall DoDrawText(Fmxtee::Engine::TCustomAxisPanel* const AParent)/* overload */;
	void __fastcall DoDrawText()/* overload */;
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual int __fastcall GetXOffset();
	virtual System::UnicodeString __fastcall GetText();
	System::Types::TRectF __fastcall GetTextBounds(/* out */ int &x, /* out */ int &y)/* overload */;
	System::Types::TRectF __fastcall GetTextBounds(Fmxtee::Engine::TCustomAxisPanel* Panel, /* out */ int &x, /* out */ int &y)/* overload */;
	virtual System::Types::TRectF __fastcall GetTextBounds(Fmxtee::Engine::TCustomAxisPanel* const Panel, const System::Types::TRectF &ABounds, /* out */ int &x, /* out */ int &y)/* overload */;
	virtual void __fastcall SetName(const System::Classes::TComponentName Value);
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	void __fastcall SetText(const System::UnicodeString Value);
	
public:
	__fastcall virtual TAnnotationTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TAnnotationTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	bool __fastcall Clicked(int x, int y);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property System::Types::TRectF Bounds = {read=GetBounds, write=SetBounds};
	
__published:
	__property Active = {default=1};
	__property bool AutoSize = {read=GetAutoSize, write=SetAutoSize, default=1};
	__property TAnnotationCallout* Callout = {read=FCallout, write=SetCallout};
	__property bool ClipText = {read=GetClipText, write=SetClipText, default=1};
	__property System::Uitypes::TCursor Cursor = {read=GetCursor, write=SetCursor, default=0};
	__property bool Draw3D = {read=FDraw3D, write=SetDraw3D, default=0};
	__property TAnnotationPosition Position = {read=FPosition, write=SetPosition, default=0};
	__property Fmxtee::Procs::TTeeUnits PositionUnits = {read=FPositionUnits, write=SetPositionUnits, default=1};
	__property Fmxtee::Engine::TTeeSelected* Selected = {read=FSelected, write=SetSelected};
	__property Fmxtee::Chart::TTextShape* Shape = {read=FShape, write=SetShape};
	__property System::UnicodeString Text = {read=GetText, write=SetText, stored=false};
	__property System::Classes::TAlignment TextAlignment = {read=GetTextAlign, write=SetTextAlign, default=0};
	__property int Height = {read=GetHeight, write=SetHeight, stored=IsNotAutoSize, nodefault};
	__property int Left = {read=GetLeft, write=SetLeft, stored=false, nodefault};
	__property int Top = {read=GetTop, write=SetTop, stored=false, nodefault};
	__property int Width = {read=GetWidth, write=SetWidth, stored=IsNotAutoSize, nodefault};
	__property int Z = {read=FZ, write=SetZ, default=0};
	__property System::Classes::TNotifyEvent OnAfterDraw = {read=FOnAfterDraw, write=FOnAfterDraw};
	__property System::Classes::TNotifyEvent OnBeforeDraw = {read=FOnBeforeDraw, write=FOnBeforeDraw};
	__property TAnnotationClick OnClick = {read=FOnClick, write=FOnClick};
	__property TAnnotationClick OnDblClick = {read=FOnDblClick, write=FOnDblClick};
};


enum DECLSPEC_DENUM TCursorToolStyle : unsigned char { cssHorizontal, cssVertical, cssBoth, cssScope, cssScopeOnly };

enum DECLSPEC_DENUM TCursorClicked : unsigned char { ccNone, ccHorizontal, ccVertical, ccBoth };

typedef void __fastcall (__closure *TCursorToolChangeEvent)(TCursorTool* Sender, int x, int y, const double XValue, const double YValue, Fmxtee::Engine::TChartSeries* Series, int ValueIndex);

typedef void __fastcall (__closure *TCursorToolGetAxisRect)(TCursorTool* Sender, System::Types::TRectF &Rect);

enum DECLSPEC_DENUM TSnapStyle : unsigned char { ssDefault, ssHorizontal, ssVertical };

enum DECLSPEC_DENUM TScopeCursorStyle : unsigned char { scsRectangle, scsCircle, scsDiamond, scsEmpty, scsCamera };

class PASCALIMPLEMENTATION TCursorTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	TAnnotationTool* FAxisAnnotation;
	int FClick;
	bool FFollowMouse;
	bool FFullRepaint;
	int FHorizSize;
	TCursorToolChangeEvent FOnChange;
	TCursorToolGetAxisRect FOnGetAxisRect;
	TCursorToolChangeEvent FOnSnapChange;
	int FScopeSize;
	TScopeCursorStyle FScopeStyle;
	bool FSnap;
	TSnapStyle FSnapStyle;
	TCursorToolStyle FStyle;
	bool FUseChartRect;
	bool FUseSeriesZ;
	int FVertSize;
	bool IValidXPoint;
	bool IValidYPoint;
	bool IAxisValid;
	TCursorClicked IDragging;
	int IOldSnap;
	void __fastcall CalcValuePositions(int X, int Y);
	void __fastcall DoChange();
	void __fastcall DrawCursorLines(bool Draw3D, int X, int Y);
	void __fastcall DrawScope(bool Draw3D, int X, int Y);
	TAnnotationTool* __fastcall GetAxisAnnotation();
	System::Types::TRectF __fastcall GetAxisRect();
	bool __fastcall InMouseRectangle(int x, int y, bool UseSize = false);
	System::Types::TRectF __fastcall MouseRectangle(const System::Types::TRectF &R, const int X, const int Y, bool UseSize);
	void __fastcall SetAxisAnnotation(TAnnotationTool* const Value);
	void __fastcall SetFullRepaint(const bool Value);
	void __fastcall SetHorizSize(const int Value);
	void __fastcall SetScopeSize(const int Value);
	void __fastcall SetScopeStyle(const TScopeCursorStyle Value);
	void __fastcall SetStyle(TCursorToolStyle Value);
	void __fastcall SetUseChartRect(const bool Value);
	void __fastcall SetUseSeriesZ(const bool Value);
	void __fastcall SetVertSize(const int Value);
	void __fastcall SetXValue(const double Value);
	void __fastcall SetYValue(const double Value);
	bool __fastcall ShouldForceRepaint();
	int __fastcall Z();
	
protected:
	double IXValue;
	double IYValue;
	System::Types::TPointF IPoint;
	void __fastcall CalcScreenPositions();
	virtual void __fastcall Changed(int SnapPoint);
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	DYNAMIC System::Classes::TComponent* __fastcall GetChildOwner();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* const Value);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	
public:
	double CustomZ;
	__fastcall virtual TCursorTool(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	TCursorClicked __fastcall Clicked(int x, int y);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	int __fastcall NearestPoint(TCursorToolStyle AStyle, /* out */ double &Difference);
	int __fastcall SnapToPoint();
	void __fastcall RedrawCursor();
	__property bool UseChartRect = {read=FUseChartRect, write=SetUseChartRect, default=0};
	__property TCursorToolGetAxisRect OnGetAxisRect = {read=FOnGetAxisRect, write=FOnGetAxisRect};
	
__published:
	__property Active = {default=1};
	__property TAnnotationTool* AxisAnnotation = {read=GetAxisAnnotation, write=SetAxisAnnotation};
	__property int ClickTolerance = {read=FClick, write=FClick, default=3};
	__property bool FollowMouse = {read=FFollowMouse, write=FFollowMouse, default=0};
	__property bool FullRepaint = {read=FFullRepaint, write=SetFullRepaint, default=0};
	__property int HorizSize = {read=FHorizSize, write=SetHorizSize, default=0};
	__property Pen;
	__property Series;
	__property int ScopeSize = {read=FScopeSize, write=SetScopeSize, default=4};
	__property TScopeCursorStyle ScopeStyle = {read=FScopeStyle, write=SetScopeStyle, default=0};
	__property bool Snap = {read=FSnap, write=FSnap, default=0};
	__property TSnapStyle SnapStyle = {read=FSnapStyle, write=FSnapStyle, default=0};
	__property TCursorToolStyle Style = {read=FStyle, write=SetStyle, default=2};
	__property bool UseSeriesZ = {read=FUseSeriesZ, write=SetUseSeriesZ, default=0};
	__property int VertSize = {read=FVertSize, write=SetVertSize, default=0};
	__property double XValue = {read=IXValue, write=SetXValue};
	__property double YValue = {read=IYValue, write=SetYValue};
	__property TCursorToolChangeEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TCursorToolChangeEvent OnSnapChange = {read=FOnSnapChange, write=FOnSnapChange};
public:
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TCursorTool() { }
	
};


typedef void __fastcall (__closure *TDragMarkEvent)(TDragMarksTool* Sender, int Index, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);

class PASCALIMPLEMENTATION TDragMarksTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	TDragMarkEvent FOnDragged;
	TDragMarkEvent FOnDragging;
	int IOldX;
	int IOldY;
	int Index;
	Fmxtee::Engine::TChartSeries* ISeries;
	
protected:
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TDragMarksTool(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Active = {default=1};
	__property Series;
	__property TDragMarkEvent OnDraggedMark = {read=FOnDragged, write=FOnDragged};
	__property TDragMarkEvent OnDraggingMark = {read=FOnDragging, write=FOnDragging};
public:
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TDragMarksTool() { }
	
};


typedef void __fastcall (__closure *TAxisArrowClickEvent)(TAxisArrowTool* Sender, bool AtStart);

enum DECLSPEC_DENUM TAxisArrowToolPosition : unsigned char { aaStart, aaEnd, aaBoth };

class PASCALIMPLEMENTATION TAxisArrowTool : public Fmxtee::Engine::TTeeCustomToolAxis
{
	typedef Fmxtee::Engine::TTeeCustomToolAxis inherited;
	
private:
	int FHeadWidth;
	int FLength;
	TAxisArrowToolPosition FPosition;
	int FScrollPercent;
	bool FScrollInverted;
	int FSizePercent;
	TAxisArrowClickEvent FOnClick;
	int __fastcall ClickedArrow(int x, int y);
	void __fastcall SetHeadWidth(const int Value);
	void __fastcall SetLength(const int Value);
	void __fastcall SetPosition(const TAxisArrowToolPosition Value);
	void __fastcall SetSizePercent(const int Value);
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TAxisArrowTool(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property Axis;
	
__published:
	__property Active = {default=1};
	__property TAxisArrowToolPosition Position = {read=FPosition, write=SetPosition, default=2};
	__property Brush;
	__property int HeadWidth = {read=FHeadWidth, write=SetHeadWidth, default=8};
	__property int Length = {read=FLength, write=SetLength, default=16};
	__property Pen;
	__property bool ScrollInverted = {read=FScrollInverted, write=FScrollInverted, default=0};
	__property int ScrollPercent = {read=FScrollPercent, write=FScrollPercent, default=10};
	__property int SizePercent = {read=FSizePercent, write=SetSizePercent, default=50};
	__property TAxisArrowClickEvent OnClick = {read=FOnClick, write=FOnClick};
public:
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TAxisArrowTool() { }
	
};


enum DECLSPEC_DENUM TScrollThumbStyle : unsigned char { stsCustom, stsThumb1, stsThumb2, stsThumb3, stsThumb4 };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TScrollBarThumb : public Fmxtee::Procs::TTeeCustomShapeBrushPen
{
	typedef Fmxtee::Procs::TTeeCustomShapeBrushPen inherited;
	
private:
	int FSize;
	TScrollThumbStyle FStyle;
	Fmxtee::Engine::TTeeCustomTool* IScroll;
	Fmxtee::Canvas::TTeeGradient* __fastcall GetGradient();
	void __fastcall SetGradient(Fmxtee::Canvas::TTeeGradient* const Value);
	Fmxtee::Canvas::TTeePicture* __fastcall GetImage();
	bool __fastcall HasImage();
	void __fastcall SetImage(Fmxtee::Canvas::TTeePicture* const Value);
	void __fastcall SetSize(const int Value);
	void __fastcall SetStyle(const TScrollThumbStyle Value);
	
public:
	__fastcall TScrollBarThumb(Fmxtee::Engine::TTeeCustomTool* const AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Brush;
	__property Pen;
	__property Visible;
	__property Fmxtee::Canvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property Fmxtee::Canvas::TTeePicture* Image = {read=GetImage, write=SetImage};
	__property int Size = {read=FSize, write=SetSize, default=0};
	__property TScrollThumbStyle Style = {read=FStyle, write=SetStyle, default=0};
public:
	/* TTeeCustomShapeBrushPen.Destroy */ inline __fastcall virtual ~TScrollBarThumb() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TTeeScrollBarDrawStyle : unsigned char { dsAlways, dsWhenNeeded };

enum DECLSPEC_DENUM TTeeScrollBarPart : unsigned char { spNone, spThumb, spArrowInc, spArrowDec, spResizeInc, spResizeDec };

typedef void __fastcall (__closure *TSetPositionEvent)(TTeeScrollBar* Sender, int Value);

class PASCALIMPLEMENTATION TTeeScrollBar : public Fmxtee::Engine::TTeeCustomTool
{
	typedef Fmxtee::Engine::TTeeCustomTool inherited;
	
private:
	TTeeScrollBarDrawStyle FDrawStyle;
	int FInitial;
	float ThumbBegin;
	float ThumbEnd;
	TScrollBarThumb* FThumb;
	Fmx::Types::TTimer* FTimer;
	System::Classes::TNotifyEvent FOnScrolled;
	TTeeScrollBarPart FIn;
	bool FirstTime;
	System::Types::TPointF OldPoint;
	bool FAllowResize;
	bool FAutoRepeat;
	Fmxtee::Procs::TPanelBevel FBevel;
	Fmxtee::Canvas::TTeeBrush* FArrowBrush;
	bool FArrows;
	Fmxtee::Canvas::TTeeBrush* FDisabledArrow;
	int FMinSize;
	int FPosition;
	TSetPositionEvent FOnSetPosition;
	System::Classes::TNotifyEvent FOnChangeSize;
	int FRoundSize;
	int FSize;
	bool FDecOutline;
	bool FIncOutline;
	void __fastcall ApplyScroll(double Delta, bool ActivateTimer);
	bool __fastcall ClickedDec(const System::Types::TPointF &P);
	bool __fastcall ClickedInc(const System::Types::TPointF &P);
	bool __fastcall ClickedResize(bool IsInc, const float X, const float Y);
	bool __fastcall ClickedThumb(const System::Types::TPointF &P);
	System::Types::TRectF __fastcall DecRectangle();
	void __fastcall DoScroll();
	void __fastcall DoTimer(System::TObject* Sender);
	void __fastcall DecArrow(/* out */ Fmxtee::Canvas::TTrianglePoints &P);
	void __fastcall DrawArrow(bool IsDisabled, const Fmxtee::Canvas::TTrianglePoints &P);
	System::Uitypes::TAlphaColor __fastcall GetBackColor();
	Fmxtee::Canvas::TTeeGradient* __fastcall GetGradient();
	Fmxtee::Canvas::TTeeBrush* __fastcall GetThumbBrush();
	int __fastcall GetThumbSize();
	void __fastcall IncArrow(/* out */ Fmxtee::Canvas::TTrianglePoints &P);
	System::Types::TRectF __fastcall IncRectangle();
	void __fastcall MouseMove(int X, int Y);
	void __fastcall MouseUp();
	void __fastcall ProcessClick(const System::Types::TPointF &P);
	void __fastcall SetArrowBrush(Fmxtee::Canvas::TTeeBrush* const Value);
	void __fastcall SetArrows(const bool Value);
	void __fastcall SetBackColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetBevel(const Fmxtee::Procs::TPanelBevel Value);
	void __fastcall SetDisabledArrow(Fmxtee::Canvas::TTeeBrush* const Value);
	void __fastcall SetGradient(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetHorizontal(const bool Value);
	void __fastcall SetMinSize(const int Value);
	void __fastcall SetRoundSize(const int Value);
	void __fastcall SetThumb(TScrollBarThumb* const Value);
	void __fastcall SetThumbBrush(Fmxtee::Canvas::TTeeBrush* const Value);
	void __fastcall SetThumbSize(const int Value);
	System::Types::TRectF __fastcall ThumbRectangle();
	
protected:
	bool FHorizontal;
	System::Types::TRectF R;
	int Max;
	int ThumbLength;
	virtual double __fastcall CalcDelta(const float A, const float B);
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual int __fastcall CurrentCount();
	virtual int __fastcall DeltaMain();
	void __fastcall Draw();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual int __fastcall GetPosition();
	virtual void __fastcall InflateThumbLength(bool IsInc, const double ADelta);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetPosition(int Value);
	virtual void __fastcall SetSize(const int Value);
	virtual bool __fastcall ShouldDraw(System::Types::TRectF &R);
	virtual int __fastcall TotalCount();
	
public:
	__fastcall virtual TTeeScrollBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTeeScrollBar();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	void __fastcall EnsureVisible(int AIndex);
	System::Types::TRectF __fastcall MainRectangle();
	System::Types::TRectF __fastcall ScrollRectangle();
	__property bool Horizontal = {read=FHorizontal, write=SetHorizontal, default=0};
	__property int Position = {read=GetPosition, write=SetPosition, nodefault};
	
__published:
	__property Active = {default=1};
	__property bool AllowResize = {read=FAllowResize, write=FAllowResize, default=0};
	__property Fmxtee::Canvas::TTeeBrush* ArrowBrush = {read=FArrowBrush, write=SetArrowBrush};
	__property bool Arrows = {read=FArrows, write=SetArrows, default=1};
	__property bool AutoRepeat = {read=FAutoRepeat, write=FAutoRepeat, default=1};
	__property System::Uitypes::TAlphaColor BackColor = {read=GetBackColor, write=SetBackColor, default=15790320};
	__property Fmxtee::Procs::TPanelBevel Bevel = {read=FBevel, write=SetBevel, default=2};
	__property Brush;
	__property Fmxtee::Canvas::TTeeBrush* DisabledArrow = {read=FDisabledArrow, write=SetDisabledArrow};
	__property TTeeScrollBarDrawStyle DrawStyle = {read=FDrawStyle, write=FDrawStyle, nodefault};
	__property Fmxtee::Canvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property int InitialDelay = {read=FInitial, write=FInitial, default=250};
	__property int MinThumbSize = {read=FMinSize, write=SetMinSize, default=4};
	__property Pen;
	__property int RoundSize = {read=FRoundSize, write=SetRoundSize, default=0};
	__property int Size = {read=FSize, write=SetSize, default=18};
	__property TScrollBarThumb* Thumb = {read=FThumb, write=SetThumb};
	__property Fmxtee::Canvas::TTeeBrush* ThumbBrush = {read=GetThumbBrush, write=SetThumbBrush};
	__property int ThumbSize = {read=GetThumbSize, write=SetThumbSize, default=0};
	__property System::Classes::TNotifyEvent OnChangeSize = {read=FOnChangeSize, write=FOnChangeSize};
	__property System::Classes::TNotifyEvent OnScrolled = {read=FOnScrolled, write=FOnScrolled};
	__property TSetPositionEvent OnSetPosition = {read=FOnSetPosition, write=FOnSetPosition};
};


class PASCALIMPLEMENTATION TAxisScrollBarTool : public TTeeScrollBar
{
	typedef TTeeScrollBar inherited;
	
private:
	Fmxtee::Engine::TChartAxis* FAxis;
	int FMargin;
	void __fastcall ChangeAxisMinMax(const double AMin, const double AMax);
	void __fastcall PrepareMargin();
	void __fastcall PrepareScrollBar();
	void __fastcall ReadAxis(System::Classes::TReader* Reader);
	void __fastcall SetMargin(const int Value);
	void __fastcall WriteAxis(System::Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual int __fastcall CurrentCount();
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall InflateThumbLength(bool IsInc, const double ADelta);
	void __fastcall InternalSetAxis(Fmxtee::Engine::TChartAxis* const Value);
	void __fastcall Reposition();
	virtual void __fastcall SetActive(bool Value);
	void __fastcall SetAxis(Fmxtee::Engine::TChartAxis* const Value);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetPosition(int Value);
	virtual void __fastcall SetSize(const int Value);
	virtual bool __fastcall ShouldDraw(System::Types::TRectF &R);
	
public:
	__fastcall virtual TAxisScrollBarTool(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod void __fastcall GetAxisLimits(Fmxtee::Engine::TChartAxis* const Axis, /* out */ double &ARange, /* out */ double &AMin, /* out */ double &AMax);
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property Fmxtee::Engine::TChartAxis* Axis = {read=FAxis, write=SetAxis, stored=false};
	
__published:
	__property AllowResize = {default=1};
	__property int Margin = {read=FMargin, write=SetMargin, default=5};
public:
	/* TTeeScrollBar.Destroy */ inline __fastcall virtual ~TAxisScrollBarTool() { }
	
};


enum DECLSPEC_DENUM TAxisScrollLimit : unsigned char { slNone, slMinimum, slMaximum, slBoth };

class PASCALIMPLEMENTATION TAxisScrollTool : public Fmxtee::Engine::TTeeCustomToolAxis
{
	typedef Fmxtee::Engine::TTeeCustomToolAxis inherited;
	
private:
	TAxisScrollLimit FLimit;
	bool FScrollInverted;
	int OldX;
	int OldY;
	Fmxtee::Engine::TChartAxis* InAxis;
	
protected:
	virtual void __fastcall SetAxis(Fmxtee::Engine::TChartAxis* const Value);
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property Axis;
	
__published:
	__property Active = {default=1};
	__property TAxisScrollLimit Limit = {read=FLimit, write=FLimit, default=0};
	__property bool ScrollInverted = {read=FScrollInverted, write=FScrollInverted, default=0};
public:
	/* TCustomChartElement.Create */ inline __fastcall virtual TAxisScrollTool(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeCustomToolAxis(AOwner) { }
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TAxisScrollTool() { }
	
};


enum DECLSPEC_DENUM TDrawLineHandle : unsigned char { chNone, chStart, chEnd, chSeries };

enum DECLSPEC_DENUM TDrawLineStyle : unsigned char { dlLine, dlHorizParallel, dlVertParallel, dlRectangle, dlEllipse };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TDrawLine : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Fmxtee::Canvas::TTeePen* FPen;
	TDrawLineStyle FStyle;
	TDrawLineTool* IParent;
	Fmxtee::Canvas::TTeePen* __fastcall GetPen();
	float __fastcall GetX0();
	float __fastcall GetX1();
	float __fastcall GetY0();
	float __fastcall GetY1();
	bool __fastcall IsPenStored();
	void __fastcall SetPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetStyle(TDrawLineStyle Value);
	void __fastcall SetX0(const float Value);
	void __fastcall SetX1(const float Value);
	void __fastcall SetY0(const float Value);
	void __fastcall SetY1(const float Value);
	
public:
	Fmxtee::Canvas::TFloatPoint EndPos;
	Fmxtee::Canvas::TFloatPoint StartPos;
	__fastcall virtual TDrawLine(System::Classes::TCollection* Collection);
	__fastcall TDrawLine(System::Classes::TCollection* Collection, const double X0, const double Y0, const double X1, const double Y1);
	__fastcall virtual ~TDrawLine();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	bool __fastcall Clicked(int X, int Y, TDrawLineHandle AHandle, int PixelsTolerance = 0x0);
	void __fastcall DrawHandles();
	System::Types::TRectF __fastcall EndHandle();
	System::Types::TRectF __fastcall StartHandle();
	__property TDrawLineTool* Parent = {read=IParent};
	
__published:
	__property Fmxtee::Canvas::TTeePen* Pen = {read=GetPen, write=SetPen, stored=IsPenStored};
	__property TDrawLineStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property float X0 = {read=GetX0, write=SetX0};
	__property float Y0 = {read=GetY0, write=SetY0};
	__property float X1 = {read=GetX1, write=SetX1};
	__property float Y1 = {read=GetY1, write=SetY1};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TDrawLines : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TDrawLine* operator[](int Index) { return this->Line[Index]; }
	
private:
	TDrawLine* __fastcall Get(int Index);
	void __fastcall Put(int Index, TDrawLine* const Value);
	
public:
	TDrawLine* __fastcall AddLine(const double X0, const double Y0, const double X1, const double Y1);
	TDrawLine* __fastcall Last();
	__property TDrawLine* Line[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TDrawLines(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TDrawLines() { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TDrawLineSelecting)(TDrawLineTool* Sender, TDrawLine* Line, bool &AllowSelect);

class PASCALIMPLEMENTATION TDrawLineTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	System::Uitypes::TMouseButton FButton;
	int FClick;
	bool FEnableDraw;
	bool FEnableSelect;
	bool FFullRepaint;
	TDrawLines* FLines;
	bool FSelectNew;
	TDrawLineStyle FStyle;
	System::Classes::TNotifyEvent FOnDraggedLine;
	System::Classes::TNotifyEvent FOnDragLine;
	System::Classes::TNotifyEvent FOnNewLine;
	System::Classes::TNotifyEvent FOnSelect;
	TDrawLineSelecting FOnSelecting;
	bool IDrawing;
	bool IMoved;
	System::Types::TPointF IPoint;
	TDrawLine* ISelected;
	void __fastcall DrawLine(const System::Types::TPointF &StartPos, const System::Types::TPointF &EndPos, TDrawLineStyle AStyle);
	TDrawLine* __fastcall InternalClicked(int X, int Y, TDrawLineHandle AHandle, int ClickTolerance)/* overload */;
	TDrawLine* __fastcall InternalClicked(int X, int Y, TDrawLineHandle AHandle)/* overload */;
	void __fastcall RedrawLine(TDrawLine* const ALine);
	void __fastcall SetEnableSelect(bool Value);
	void __fastcall SetFullRepaint(bool Value);
	void __fastcall SetLines(TDrawLines* const Value);
	void __fastcall SetSelected(TDrawLine* const Value);
	bool __fastcall ShouldForceRepaint();
	
protected:
	TDrawLineHandle IHandle;
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton AButton, System::Classes::TShiftState AShift, int X, int Y);
	virtual void __fastcall ClipDrawingRegion();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	System::Types::TPointF FromPoint;
	System::Types::TPointF ToPoint;
	__fastcall virtual TDrawLineTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TDrawLineTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	System::Types::TPointF __fastcall AxisPoint(const Fmxtee::Canvas::TFloatPoint &P);
	TDrawLine* __fastcall Clicked(int X, int Y)/* overload */;
	TDrawLine* __fastcall Clicked(int X, int Y, int ClickTolerance)/* overload */;
	void __fastcall DeleteSelected();
	Fmxtee::Canvas::TFloatPoint __fastcall ScreenPoint(const System::Types::TPointF &P);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property TDrawLine* Selected = {read=ISelected, write=SetSelected};
	
__published:
	__property Active = {default=1};
	__property System::Uitypes::TMouseButton Button = {read=FButton, write=FButton, default=0};
	__property int ClickTolerance = {read=FClick, write=FClick, default=0};
	__property bool EnableDraw = {read=FEnableDraw, write=FEnableDraw, default=1};
	__property bool EnableSelect = {read=FEnableSelect, write=SetEnableSelect, default=1};
	__property bool FullRepaint = {read=FFullRepaint, write=SetFullRepaint, default=0};
	__property TDrawLines* Lines = {read=FLines, write=SetLines};
	__property bool SelectNewLines = {read=FSelectNew, write=FSelectNew, default=1};
	__property Pen;
	__property Series;
	__property TDrawLineStyle Style = {read=FStyle, write=FStyle, default=0};
	__property System::Classes::TNotifyEvent OnDraggedLine = {read=FOnDraggedLine, write=FOnDraggedLine};
	__property System::Classes::TNotifyEvent OnDragLine = {read=FOnDragLine, write=FOnDragLine};
	__property System::Classes::TNotifyEvent OnNewLine = {read=FOnNewLine, write=FOnNewLine};
	__property System::Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property TDrawLineSelecting OnSelecting = {read=FOnSelecting, write=FOnSelecting};
};


typedef System::TMetaClass* TDrawLineClass;

enum DECLSPEC_DENUM TMarkToolMouseAction : unsigned char { mtmMove, mtmClick };

typedef void __fastcall (__closure *TMarksTipGetText)(TMarksTipTool* Sender, System::UnicodeString &Text);

class PASCALIMPLEMENTATION TMarksTipTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	Fmxtee::Chart::TTextShape* FFormat;
	TMarkToolMouseAction FMouseAction;
	System::Classes::TNotifyEvent FOnCancel;
	TMarksTipGetText FOnGetText;
	Fmxtee::Engine::TSeriesMarksStyle FStyle;
	bool FSystemHints;
	int FHidePause;
	int FMouseDelay;
	Fmx::Types::TTimer* ITimer;
	Fmxtee::Canvas::TTeeFont* __fastcall GetFont();
	int __fastcall GetHideDelay();
	int __fastcall GetMouseDelay();
	void __fastcall SetFont(Fmxtee::Canvas::TTeeFont* const Value);
	void __fastcall SetFormat(Fmxtee::Chart::TTextShape* const Value);
	void __fastcall SetHideDelay(const int Value);
	void __fastcall SetMouseAction(TMarkToolMouseAction Value);
	void __fastcall SetMouseDelay(const int Value);
	void __fastcall TimerCancelHint(System::TObject* Sender);
	
protected:
	Fmxtee::Chart::TCustomChart* __fastcall Chart();
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall Loaded();
	
public:
	__fastcall virtual TMarksTipTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TMarksTipTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall HideHint();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Active = {default=1};
	__property Fmxtee::Canvas::TTeeFont* Font = {read=GetFont, write=SetFont, stored=false};
	__property Fmxtee::Chart::TTextShape* Format = {read=FFormat, write=SetFormat};
	__property int HideDelay = {read=GetHideDelay, write=SetHideDelay, default=2500};
	__property TMarkToolMouseAction MouseAction = {read=FMouseAction, write=SetMouseAction, default=0};
	__property int MouseDelay = {read=GetMouseDelay, write=SetMouseDelay, default=500};
	__property Series;
	__property Fmxtee::Engine::TSeriesMarksStyle Style = {read=FStyle, write=FStyle, default=14};
	__property bool SystemHints = {read=FSystemHints, write=FSystemHints, default=0};
	__property System::Classes::TNotifyEvent OnCancelHint = {read=FOnCancel, write=FOnCancel};
	__property TMarksTipGetText OnGetText = {read=FOnGetText, write=FOnGetText};
};


enum DECLSPEC_DENUM TNearestToolStyle : unsigned char { hsNone, hsCircle, hsRectangle, hsDiamond, hsSeries };

class PASCALIMPLEMENTATION TNearestTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	int FDistance;
	bool FFullRepaint;
	bool FHint;
	Fmxtee::Engine::TSeriesMarksStyle FHintStyle;
	Fmxtee::Canvas::TTeePen* FLinePen;
	int FSize;
	TNearestToolStyle FStyle;
	System::Classes::TNotifyEvent FOnChange;
	TMarksTipGetText FOnGetHint;
	System::Types::TPointF IMouse;
	bool __fastcall GetDrawLine();
	void __fastcall PaintHint();
	void __fastcall SetDrawLine(const bool Value);
	void __fastcall SetLinePen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetSize(const int Value);
	void __fastcall SetStyle(const TNearestToolStyle Value);
	bool __fastcall ShouldForceRepaint();
	int __fastcall ZAxisCalc(const double Value);
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	int Point;
	__fastcall virtual TNearestTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TNearestTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod int __fastcall GetNearestPoint(Fmxtee::Engine::TChartSeries* Series, int X, int Y, int MaxDistance = 0x0)/* overload */;
	__classmethod int __fastcall GetNearestPoint(Fmxtee::Engine::TChartSeries* Series, int X, int Y, bool IncludeNulls, int MaxDistance = 0x0)/* overload */;
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Active = {default=1};
	__property Brush;
	__property int Distance = {read=FDistance, write=FDistance, default=0};
	__property bool DrawLine = {read=GetDrawLine, write=SetDrawLine, default=1};
	__property bool FullRepaint = {read=FFullRepaint, write=FFullRepaint, default=1};
	__property bool Hint = {read=FHint, write=FHint, default=0};
	__property Fmxtee::Engine::TSeriesMarksStyle HintStyle = {read=FHintStyle, write=FHintStyle, default=4};
	__property Fmxtee::Canvas::TTeePen* LinePen = {read=FLinePen, write=SetLinePen};
	__property Pen;
	__property Series;
	__property int Size = {read=FSize, write=SetSize, default=20};
	__property TNearestToolStyle Style = {read=FStyle, write=SetStyle, default=1};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TMarksTipGetText OnGetHint = {read=FOnGetHint, write=FOnGetHint};
};


class PASCALIMPLEMENTATION TColorBandTool : public Fmxtee::Engine::TTeeCustomToolAxis
{
	typedef Fmxtee::Engine::TTeeCustomToolAxis inherited;
	
private:
	bool FAllowDrag;
	bool FNoLimitDrag;
	System::Uitypes::TAlphaColor FColor;
	System::Uitypes::TCursor FCursor;
	bool FDrawBehind;
	bool FDrawBehindAxes;
	double FEnd;
	System::Classes::TNotifyEvent FOnChanged;
	Fmx::Types::TMouseEvent FOnClick;
	System::Classes::TNotifyEvent FOnDragging;
	System::Classes::TNotifyEvent FOnResized;
	System::Classes::TNotifyEvent FOnResizing;
	Fmxtee::Canvas::TTeePicture* FPicture;
	double FStart;
	Fmxtee::Canvas::TTeeTransparency FTransparency;
	TColorLineTool* FLineEnd;
	TColorLineTool* FLineStart;
	bool IDragged;
	bool IDragging;
	double IOld;
	Fmxtee::Engine::TCustomAxisPanel* __fastcall Chart();
	void __fastcall DoChanged();
	void __fastcall DragLine(TColorLineTool* Sender);
	void __fastcall EndDragLine(TColorLineTool* Sender);
	Fmxtee::Canvas::TTeePen* __fastcall GetEndLinePen();
	Fmxtee::Canvas::TTeeGradient* __fastcall GetGradient();
	Fmxtee::Canvas::TTeePicture* __fastcall GetPicture();
	bool __fastcall GetResizeEnd();
	bool __fastcall GetResizeStart();
	Fmxtee::Canvas::TTeePen* __fastcall GetStartLinePen();
	void __fastcall InitColorLine(TColorLineTool* const Value);
	TColorLineTool* __fastcall NewColorLine();
	void __fastcall PaintBand();
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall SetColor(System::Uitypes::TAlphaColor Value);
	void __fastcall SetDrawBehind(const bool Value);
	void __fastcall SetDrawBehindAxes(const bool Value);
	void __fastcall SetEnd(const double Value);
	void __fastcall SetEndLinePen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetGradient(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetLines();
	void __fastcall SetPicture(Fmxtee::Canvas::TTeePicture* const Value);
	void __fastcall SetResizeEnd(const bool Value);
	void __fastcall SetResizeStart(const bool Value);
	void __fastcall SetStart(const double Value);
	void __fastcall SetStartLinePen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetTransparency(const Fmxtee::Canvas::TTeeTransparency Value);
	
protected:
	Fmxtee::Engine::TCustomAxisPanel* IParent;
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	DYNAMIC System::Classes::TComponent* __fastcall GetChildOwner();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall Loaded();
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual void __fastcall SetAxis(Fmxtee::Engine::TChartAxis* const Value);
	void __fastcall SetParent(Fmxtee::Engine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	int __fastcall ZPosition();
	
public:
	__fastcall virtual TColorBandTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TColorBandTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	System::Types::TRectF __fastcall BoundsRect();
	bool __fastcall Clicked(int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property TColorLineTool* StartLine = {read=FLineStart};
	__property TColorLineTool* EndLine = {read=FLineEnd};
	__property System::Classes::TNotifyEvent OnChanged = {read=FOnChanged, write=FOnChanged};
	__property Axis;
	
__published:
	__property Active = {default=1};
	__property bool AllowDrag = {read=FAllowDrag, write=FAllowDrag, default=1};
	__property Brush;
	__property System::Uitypes::TAlphaColor Color = {read=FColor, write=SetColor, default=-1};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=FCursor, default=0};
	__property bool DrawBehind = {read=FDrawBehind, write=SetDrawBehind, default=1};
	__property bool DrawBehindAxes = {read=FDrawBehindAxes, write=SetDrawBehindAxes, default=0};
	__property double EndValue = {read=FEnd, write=SetEnd};
	__property Fmxtee::Canvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property bool NoLimitDrag = {read=FNoLimitDrag, write=FNoLimitDrag, default=1};
	__property Pen;
	__property Fmxtee::Canvas::TTeePicture* Picture = {read=GetPicture, write=SetPicture};
	__property bool ResizeEnd = {read=GetResizeEnd, write=SetResizeEnd, default=0};
	__property bool ResizeStart = {read=GetResizeStart, write=SetResizeStart, default=0};
	__property double StartValue = {read=FStart, write=SetStart};
	__property Fmxtee::Canvas::TTeeTransparency Transparency = {read=FTransparency, write=SetTransparency, default=0};
	__property Fmxtee::Canvas::TTeePen* EndLinePen = {read=GetEndLinePen, write=SetEndLinePen};
	__property Fmxtee::Canvas::TTeePen* StartLinePen = {read=GetStartLinePen, write=SetStartLinePen};
	__property Fmx::Types::TMouseEvent OnClick = {read=FOnClick, write=FOnClick};
	__property System::Classes::TNotifyEvent OnDragging = {read=FOnDragging, write=FOnDragging};
	__property System::Classes::TNotifyEvent OnResized = {read=FOnResized, write=FOnResized};
	__property System::Classes::TNotifyEvent OnResizing = {read=FOnResizing, write=FOnResizing};
};


class PASCALIMPLEMENTATION TGridBandBrush : public Fmxtee::Canvas::TTeeBrush
{
	typedef Fmxtee::Canvas::TTeeBrush inherited;
	
private:
	Fmxtee::Canvas::TTeeTransparency FTransp;
	void __fastcall SetTransp(const Fmxtee::Canvas::TTeeTransparency Value);
	
public:
	__fastcall virtual TGridBandBrush(const System::Classes::TNotifyEvent OnChangeEvent);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property BackColor = {default=0};
	__property Fmxtee::Canvas::TTeeTransparency Transparency = {read=FTransp, write=SetTransp, default=0};
public:
	/* TTeeBrush.Destroy */ inline __fastcall virtual ~TGridBandBrush() { }
	
};


class PASCALIMPLEMENTATION TGridBandTool : public Fmxtee::Engine::TTeeCustomToolAxis
{
	typedef Fmxtee::Engine::TTeeCustomToolAxis inherited;
	
private:
	TGridBandBrush* FBand1;
	TGridBandBrush* FBand2;
	void __fastcall CleanAxis();
	void __fastcall DrawGrids(Fmxtee::Engine::TChartAxis* Sender);
	void __fastcall SetBand1(TGridBandBrush* const Value);
	void __fastcall SetBand2(TGridBandBrush* const Value);
	
protected:
	int StartPos;
	int EndPos;
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetAxis(Fmxtee::Engine::TChartAxis* const Value);
	
public:
	__fastcall virtual TGridBandTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TGridBandTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	System::Uitypes::TAlphaColor __fastcall BandBackColor(TGridBandBrush* const ABand);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property Axis;
	
__published:
	__property Active = {default=1};
	__property TGridBandBrush* Band1 = {read=FBand1, write=SetBand1};
	__property TGridBandBrush* Band2 = {read=FBand2, write=SetBand2};
};


enum DECLSPEC_DENUM TColorLineStyle : unsigned char { clCustom, clMaximum, clCenter, clMinimum };

typedef void __fastcall (__closure *TColorLineToolOnDrag)(TColorLineTool* Sender);

class PASCALIMPLEMENTATION TColorLineTool : public Fmxtee::Engine::TTeeCustomToolAxis
{
	typedef Fmxtee::Engine::TTeeCustomToolAxis inherited;
	
private:
	bool FAllowDrag;
	TAnnotationTool* FAnnotation;
	bool FAnnValue;
	int FClick;
	bool FDragRepaint;
	bool FDraw3D;
	bool FDrawBehind;
	bool FNoLimitDrag;
	TColorLineToolOnDrag FOnBeginDragLine;
	TColorLineToolOnDrag FOnDragLine;
	TColorLineToolOnDrag FOnEndDragLine;
	TColorLineStyle FStyle;
	double FValue;
	Fmxtee::Engine::TCustomAxisPanel* IParent;
	TColorLineToolOnDrag InternalOnEndDragLine;
	Fmxtee::Engine::TCustomAxisPanel* __fastcall Chart();
	void __fastcall DrawColorLine(bool Back);
	TAnnotationTool* __fastcall GetAnnotation();
	void __fastcall GetAxisStartEnd(/* out */ int &AStart, /* out */ int &AEnd);
	void __fastcall SetAnnotation(TAnnotationTool* const Value);
	void __fastcall SetAnnValue(const bool Value);
	void __fastcall SetDragRepaint(const bool Value);
	void __fastcall SetDraw3D(const bool Value);
	void __fastcall SetDrawBehind(const bool Value);
	void __fastcall SetStyle(const TColorLineStyle Value);
	void __fastcall SetValue(const double AValue);
	bool __fastcall ShouldForceRepaint();
	
protected:
	bool IDragging;
	bool ShowOutsideAxis;
	double __fastcall CalcValue();
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DoEndDragLine();
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	DYNAMIC System::Classes::TComponent* __fastcall GetChildOwner();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	void __fastcall InternalDrawLine(bool Back);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual void __fastcall SetParent(Fmxtee::Engine::TCustomAxisPanel* Value);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TColorLineTool(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	bool __fastcall Clicked(int x, int y);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	double __fastcall LimitValue(const double AValue);
	__property Axis;
	
__published:
	__property Active = {default=1};
	__property TAnnotationTool* Annotation = {read=GetAnnotation, write=SetAnnotation};
	__property bool AnnotationValue = {read=FAnnValue, write=SetAnnValue, default=0};
	__property bool AllowDrag = {read=FAllowDrag, write=FAllowDrag, default=1};
	__property int ClickTolerance = {read=FClick, write=FClick, default=3};
	__property bool DragRepaint = {read=FDragRepaint, write=SetDragRepaint, default=0};
	__property bool Draw3D = {read=FDraw3D, write=SetDraw3D, default=1};
	__property bool DrawBehind = {read=FDrawBehind, write=SetDrawBehind, default=0};
	__property bool NoLimitDrag = {read=FNoLimitDrag, write=FNoLimitDrag, default=0};
	__property Pen;
	__property TColorLineStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property double Value = {read=FValue, write=SetValue};
	__property TColorLineToolOnDrag OnBeginDragLine = {read=FOnBeginDragLine, write=FOnBeginDragLine};
	__property TColorLineToolOnDrag OnDragLine = {read=FOnDragLine, write=FOnDragLine};
	__property TColorLineToolOnDrag OnEndDragLine = {read=FOnEndDragLine, write=FOnEndDragLine};
public:
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TColorLineTool() { }
	
};


enum DECLSPEC_DENUM TRotateToolStyles : unsigned char { rsAll, rsRotation, rsElevation };

class PASCALIMPLEMENTATION TRotateTool : public Fmxtee::Engine::TTeeCustomTool
{
	typedef Fmxtee::Engine::TTeeCustomTool inherited;
	
private:
	System::Uitypes::TMouseButton FButton;
	System::Uitypes::TCursor FCursor;
	int FInertia;
	bool FInverted;
	System::Classes::TNotifyEvent FOnRotate;
	int FSpeed;
	TRotateToolStyles FStyle;
	bool IDragging;
	bool IFirstTime;
	bool IOldRepaint;
	int IOldX;
	int IOldY;
	Fmx::Types::TTimer* ITimer;
	double IDifX;
	double IDifY;
	System::Uitypes::TCursor IOldCursor;
	void __fastcall DoTimer(System::TObject* Sender);
	void __fastcall DoRotation(const double IDifX, const double IDifY);
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton AButton, System::Classes::TShiftState AShift, int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TRotateTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TRotateTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__classmethod double __fastcall ElevationChange(bool FullRotation, const double AAngle, const double AChange);
	void __fastcall Rotate(const double RotationDegrees, const double ElevationDegrees);
	__classmethod double __fastcall RotationChange(bool FullRotation, const double AAngle, const double AChange);
	
__published:
	__property Active = {default=1};
	__property System::Uitypes::TMouseButton Button = {read=FButton, write=FButton, default=0};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=FCursor, default=-21};
	__property int Inertia = {read=FInertia, write=FInertia, default=0};
	__property bool Inverted = {read=FInverted, write=FInverted, default=0};
	__property Pen;
	__property int Speed = {read=FSpeed, write=FSpeed, default=50};
	__property TRotateToolStyles Style = {read=FStyle, write=FStyle, default=0};
	__property System::Classes::TNotifyEvent OnRotate = {read=FOnRotate, write=FOnRotate};
};


class PASCALIMPLEMENTATION TChartImageTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	Fmxtee::Canvas::TTeePicture* FPicture;
	void __fastcall SetPicture(Fmxtee::Canvas::TTeePicture* const Value);
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* const Value);
	
public:
	__fastcall virtual TChartImageTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TChartImageTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Active = {default=1};
	__property Pen;
	__property Fmxtee::Canvas::TTeePicture* Picture = {read=FPicture, write=SetPicture};
	__property Series;
};


class PASCALIMPLEMENTATION TRectangleTool : public TAnnotationTool
{
	typedef TAnnotationTool inherited;
	
private:
	bool FAllowDrag;
	bool FAllowResize;
	System::Classes::TNotifyEvent FOnDragged;
	System::Classes::TNotifyEvent FOnDragging;
	System::Classes::TNotifyEvent FOnResized;
	System::Classes::TNotifyEvent FOnResizing;
	System::Types::TPointF P;
	bool IDrag;
	int IEdge;
	bool __fastcall GetResizing();
	
protected:
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TRectangleTool(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	Fmx::Graphics::TBitmap* __fastcall Bitmap(bool ChartOnly = false);
	int __fastcall ClickedEdge(int x, int y);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property bool Dragging = {read=IDrag, nodefault};
	__property bool Resizing = {read=GetResizing, nodefault};
	
__published:
	__property bool AllowDrag = {read=FAllowDrag, write=FAllowDrag, default=1};
	__property bool AllowResize = {read=FAllowResize, write=FAllowResize, default=1};
	__property AutoSize = {default=0};
	__property Cursor = {default=-21};
	__property PositionUnits = {default=1};
	__property System::Classes::TNotifyEvent OnDragged = {read=FOnDragged, write=FOnDragged};
	__property System::Classes::TNotifyEvent OnDragging = {read=FOnDragging, write=FOnDragging};
	__property System::Classes::TNotifyEvent OnResized = {read=FOnResized, write=FOnResized};
	__property System::Classes::TNotifyEvent OnResizing = {read=FOnResizing, write=FOnResizing};
public:
	/* TAnnotationTool.Destroy */ inline __fastcall virtual ~TRectangleTool() { }
	
};


class PASCALIMPLEMENTATION TClipSeriesTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
protected:
	virtual void __fastcall SeriesEvent(Fmxtee::Engine::TChartToolEvent AEvent, Fmxtee::Engine::TChartSeries* ASeries);
	
public:
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Active = {default=1};
	__property Series;
public:
	/* TCustomChartElement.Create */ inline __fastcall virtual TClipSeriesTool(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeCustomToolSeries(AOwner) { }
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TClipSeriesTool() { }
	
};


class PASCALIMPLEMENTATION TFullScreenTool : public Fmxtee::Engine::TTeeCustomTool
{
	typedef Fmxtee::Engine::TTeeCustomTool inherited;
	
private:
	System::Word FKey;
	System::Classes::TNotifyEvent FOnReset;
	Fmx::Types::TAlignLayout OldAlign;
	Fmx::Types::TFmxObject* OldParent;
	System::Types::TRectF OldRChart;
	bool IFreeForm;
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall RemoveFullScreen();
	
protected:
	virtual void __fastcall SetActive(bool Value);
	
public:
	__fastcall virtual TFullScreenTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TFullScreenTool();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__classmethod System::Types::TRectF __fastcall ScreenDesktopRect();
	
__published:
	__property Active = {default=0};
	__property System::Word ReleaseKey = {read=FKey, write=FKey, default=27};
	__property System::Classes::TNotifyEvent OnReset = {read=FOnReset, write=FOnReset};
};


enum DECLSPEC_DENUM TRepaintMonitorMode : unsigned char { rmFrames, rmMsec, rmMemory, rmTotalMemory };

class PASCALIMPLEMENTATION TRepaintMonitor : public TRectangleTool
{
	typedef TRectangleTool inherited;
	
private:
	Fmxtee::Chart::TChart* FChart;
	int FInterval;
	TRepaintMonitorMode FMode;
	int FTotalFrames;
	int FMonitor;
	float FMonitorTime;
	System::UnicodeString FMonitorText;
	Fmx::Graphics::TBitmap* IBitmap;
	float ILastMsec;
	float ILastSecond;
	int IMsec;
	int ILastMonitor;
	unsigned IMemory;
	unsigned __fastcall CalcText();
	Fmxtee::Chart::TChart* __fastcall GetChart();
	bool __fastcall GetShowChart();
	void __fastcall SetMode(const TRepaintMonitorMode Value);
	void __fastcall SetShowChart(const bool Value);
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual System::UnicodeString __fastcall GetText();
	
public:
	__fastcall virtual TRepaintMonitor(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TRepaintMonitor();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property Fmxtee::Chart::TChart* Chart = {read=GetChart};
	
__published:
	__property int Interval = {read=FInterval, write=FInterval, default=1000};
	__property TRepaintMonitorMode Mode = {read=FMode, write=SetMode, default=0};
	__property bool ShowChart = {read=GetShowChart, write=SetShowChart, default=1};
};


class PASCALIMPLEMENTATION TTeeCombo : public TAnnotationTool
{
	typedef TAnnotationTool inherited;
	
private:
	bool FAutoHide;
	bool FExpanded;
	int FItemIndex;
	System::Classes::TStringList* FItems;
	System::Classes::TNotifyEvent FOnChange;
	int IWidth;
	int IHeight;
	int ILastSelected;
	int IUnderMouse;
	void __fastcall CheckItems(System::TObject* Sender);
	void __fastcall RecalcHeight();
	void __fastcall SetAutoHide(const bool Value);
	void __fastcall SetItems(System::Classes::TStringList* const Value);
	void __fastcall SetItemIndex(const int Value);
	
protected:
	int TopIndex;
	virtual void __fastcall ChartKeyEvent(Fmxtee::Engine::TChartKeyEvent AEvent, System::Word &Key, System::WideChar &Key1, System::Classes::TShiftState Shift);
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	int __fastcall ClickedItem(int X, int Y);
	virtual void __fastcall DoDrawText(Fmxtee::Engine::TCustomAxisPanel* const AParent)/* overload */;
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	int __fastcall ItemHeight();
	
public:
	__fastcall virtual TTeeCombo(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTeeCombo();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Collapse();
	int __fastcall Count();
	void __fastcall Expand();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property bool Expanded = {read=FExpanded, nodefault};
	
__published:
	__property bool AutoHide = {read=FAutoHide, write=SetAutoHide, default=0};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=-1};
	__property System::Classes::TStringList* Items = {read=FItems, write=SetItems};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  DoDrawText(){ TAnnotationTool::DoDrawText(); }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 TeeClickTolerance = System::Int8(0x3);
static const System::Uitypes::TAlphaColor clTeeScrollBar = System::Uitypes::TAlphaColor(0xf0f0f0);
static const System::Int8 DefaultScrollBarSize = System::Int8(0x12);
extern DELPHI_PACKAGE TDrawLineClass TeeDrawLineClass;
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS)
using namespace Fmxtee::Tools;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_ToolsHPP
