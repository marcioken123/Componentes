// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Print.PreviewPanel.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Print_PreviewpanelHPP
#define Fmxtee_Print_PreviewpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Generics.Collections.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Types.hpp>
#include <System.Types.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMX.Controls.hpp>
#include <System.Generics.Defaults.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Print
{
namespace Previewpanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPreviewChartPen;
class DELPHICLASS TTeePanelsList;
class DELPHICLASS TTeePreviewPanel;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TTeePreviewPanelOrientation : unsigned char { ppoDefault, ppoPortrait, ppoLandscape };

typedef void __fastcall (__closure *TOnChangeMarginsEvent)(System::TObject* Sender, bool DisableProportional, const System::Types::TRectF &NewMargins);

typedef void __fastcall (__closure *TOnGetPaperRect)(System::TObject* Sender, System::Types::TRectF &PaperRect);

class PASCALIMPLEMENTATION TPreviewChartPen : public Fmxtee::Canvas::TTeePen
{
	typedef Fmxtee::Canvas::TTeePen inherited;
	
__published:
	__property EndStyle = {default=2};
	__property Style = {default=2};
	__property SmallDots = {default=1};
public:
	/* TTeePen.Create */ inline __fastcall TPreviewChartPen(const System::Classes::TNotifyEvent OnChangeEvent) : Fmxtee::Canvas::TTeePen(OnChangeEvent) { }
	/* TTeePen.Destroy */ inline __fastcall virtual ~TPreviewChartPen() { }
	
};


enum DECLSPEC_DENUM TeePreviewZones : unsigned char { teePrev_None, teePrev_Left, teePrev_Top, teePrev_Right, teePrev_Bottom, teePrev_Image, teePrev_LeftTop, teePrev_RightTop, teePrev_LeftBottom, teePrev_RightBottom };

class PASCALIMPLEMENTATION TTeePanelsList : public System::Generics::Collections::TList__1<Fmxtee::Procs::TCustomTeePanel*>
{
	typedef System::Generics::Collections::TList__1<Fmxtee::Procs::TCustomTeePanel*> inherited;
	
public:
	/* {System_Generics_Collections}TList<FMXTee_Procs_TCustomTeePanel>.Create */ inline __fastcall TTeePanelsList()/* overload */ : System::Generics::Collections::TList__1<Fmxtee::Procs::TCustomTeePanel*>() { }
	/* {System_Generics_Collections}TList<FMXTee_Procs_TCustomTeePanel>.Create */ inline __fastcall TTeePanelsList(const System::DelphiInterface<System::Generics::Defaults::IComparer__1<Fmxtee::Procs::TCustomTeePanel*> > AComparer)/* overload */ : System::Generics::Collections::TList__1<Fmxtee::Procs::TCustomTeePanel*>(AComparer) { }
	/* {System_Generics_Collections}TList<FMXTee_Procs_TCustomTeePanel>.Create */ inline __fastcall TTeePanelsList(System::Generics::Collections::TEnumerable__1<Fmxtee::Procs::TCustomTeePanel*>* const Collection)/* overload */ : System::Generics::Collections::TList__1<Fmxtee::Procs::TCustomTeePanel*>(Collection) { }
	/* {System_Generics_Collections}TList<FMXTee_Procs_TCustomTeePanel>.Destroy */ inline __fastcall virtual ~TTeePanelsList() { }
	
};


class PASCALIMPLEMENTATION TTeePreviewPanel : public Fmxtee::Procs::TCustomTeePanelExtended
{
	typedef Fmxtee::Procs::TCustomTeePanelExtended inherited;
	
private:
	bool FAllowResize;
	bool FAllowMove;
	bool FAsBitmap;
	TTeePanelsList* FPanels;
	bool FDragImage;
	TPreviewChartPen* FMargins;
	TTeePreviewPanelOrientation FOrientation;
	TOnChangeMarginsEvent FOnChangeMargins;
	TOnGetPaperRect FOnGetPaperRect;
	System::Uitypes::TAlphaColor FPaperColor;
	Fmxtee::Canvas::TTeeShadow* FPaperShadow;
	bool FShowImage;
	bool FSmoothBitmap;
	System::UnicodeString FTitle;
	TeePreviewZones IDragged;
	float OldX;
	float OldY;
	System::Types::TRectF OldRect;
	bool IOldShowImage;
	void __fastcall CheckPrinterOrientation();
	Fmxtee::Procs::TCustomTeePanel* __fastcall GetPanel();
	Fmx::Graphics::TBitmap* __fastcall GetPrintingBitmap(Fmxtee::Procs::TCustomTeePanel* const APanel);
	System::Uitypes::TAlphaColor __fastcall GetShadowColor();
	int __fastcall GetShadowSize();
	int __fastcall PrinterCount();
	void __fastcall SendAsBitmap(Fmxtee::Procs::TCustomTeePanel* const APanel, Fmx::Graphics::TCanvas* const ACanvas, const System::Types::TRectF &R)/* overload */;
	void __fastcall SendAsBitmap(Fmxtee::Procs::TCustomTeePanel* const APanel, const System::Types::TRectF &R)/* overload */;
	void __fastcall SetAsBitmap(bool Value);
	HIDESBASE void __fastcall SetMargins(TPreviewChartPen* const Value);
	void __fastcall SetOrientation(const TTeePreviewPanelOrientation Value);
	void __fastcall SetPanel(Fmxtee::Procs::TCustomTeePanel* const Value);
	void __fastcall SetPaperColor(System::Uitypes::TAlphaColor Value);
	void __fastcall SetPaperShadow(Fmxtee::Canvas::TTeeShadow* const Value);
	void __fastcall SetShadowColor(System::Uitypes::TAlphaColor Value);
	void __fastcall SetShadowSize(int Value);
	void __fastcall SetShowImage(bool Value);
	void __fastcall SetSmoothBitmap(const bool Value);
	
protected:
	System::Types::TRectF __fastcall CalcImagePrintMargins(Fmxtee::Procs::TCustomTeePanel* const APanel);
	void __fastcall DrawPaper();
	void __fastcall DrawPanelImage(Fmxtee::Procs::TCustomTeePanel* const APanel);
	void __fastcall DrawMargins(const System::Types::TRectF &R);
	virtual void __fastcall InternalDraw(const System::Types::TRectF &UserRectangle);
	virtual void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	virtual void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	virtual void __fastcall MouseMove(System::Classes::TShiftState Shift, float X, float Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	TeePreviewZones __fastcall WhereIsCursor(const float x, const float y);
	
public:
	System::Types::TRectF ImageRect;
	System::Types::TRectF PaperRect;
	__fastcall virtual TTeePreviewPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTeePreviewPanel();
	HIDESBASE void __fastcall Print();
	__property TTeePanelsList* Panels = {read=FPanels};
	__property System::Uitypes::TAlphaColor ShadowColor = {read=GetShadowColor, write=SetShadowColor, nodefault};
	__property int ShadowSize = {read=GetShadowSize, write=SetShadowSize, nodefault};
	
__published:
	__property bool AllowResize = {read=FAllowResize, write=FAllowResize, default=1};
	__property bool AllowMove = {read=FAllowMove, write=FAllowMove, default=1};
	__property bool AsBitmap = {read=FAsBitmap, write=SetAsBitmap, default=1};
	__property bool DragImage = {read=FDragImage, write=FDragImage, default=0};
	__property TPreviewChartPen* Margins = {read=FMargins, write=SetMargins};
	__property TTeePreviewPanelOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property Fmxtee::Procs::TCustomTeePanel* Panel = {read=GetPanel, write=SetPanel};
	__property System::Uitypes::TAlphaColor PaperColor = {read=FPaperColor, write=SetPaperColor, default=-1};
	__property Fmxtee::Canvas::TTeeShadow* PaperShadow = {read=FPaperShadow, write=SetPaperShadow};
	__property Shadow;
	__property bool ShowImage = {read=FShowImage, write=SetShowImage, default=1};
	__property bool SmoothBitmap = {read=FSmoothBitmap, write=SetSmoothBitmap, default=1};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property TOnChangeMarginsEvent OnChangeMargins = {read=FOnChangeMargins, write=FOnChangeMargins};
	__property TOnGetPaperRect OnGetPaperRect = {read=FOnGetPaperRect, write=FOnGetPaperRect};
	__property BackImage;
	__property BackImageMode = {default=0};
	__property Border;
	__property BorderRound = {default=0};
	__property Gradient;
	__property Align = {default=0};
	__property BevelInner = {default=0};
	__property BevelOuter = {default=2};
	__property BevelWidth = {default=1};
	__property BorderWidth = {default=0};
	__property DragMode = {default=0};
	__property Enabled;
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property Visible = {default=1};
	__property Action;
	__property Anchors;
	__property Position;
	__property Width;
	__property Height;
	__property ClipChildren = {default=1};
	__property Locked = {default=0};
	__property OnAfterDraw;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnMouseWheel;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Previewpanel */
}	/* namespace Print */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_PRINT_PREVIEWPANEL)
using namespace Fmxtee::Print::Previewpanel;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_PRINT)
using namespace Fmxtee::Print;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Print_PreviewpanelHPP
