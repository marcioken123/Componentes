// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomTrackBar.pas' rev: 31.00 (Windows)

#ifndef LmdcustomtrackbarHPP
#define LmdcustomtrackbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDFillObject.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomtrackbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomTrackBar;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDThumbStyle : unsigned char { tsStandard, tsCustom };

enum DECLSPEC_DENUM TLMDTickStyle : unsigned char { tsAuto, tsOwnerDraw, tsNone };

enum DECLSPEC_DENUM TLMDTickMarks : unsigned char { tmBoth, tmBottomRight, tmTopLeft };

typedef void __fastcall (__closure *TLMDDrawTickEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* aCanvas, int aValue, const System::Types::TPoint &pos);

enum DECLSPEC_DENUM TLMDTrackBarFocusStyle : unsigned char { tbFocus, tbInvisibleFocus, tbNoFocus };

class PASCALIMPLEMENTATION TLMDCustomTrackBar : public Lmdcustompanel::TLMDCustomPanel
{
	typedef Lmdcustompanel::TLMDCustomPanel inherited;
	
private:
	HIDESBASE void __fastcall SetColor(int Index, System::Uitypes::TColor aValue);
	void __fastcall SetInteger(int Index, int aValue);
	void __fastcall SetOrientation(Lmdgraph::TLMDOrientation aValue);
	void __fastcall SetPosition(int aValue);
	void __fastcall SetThumb(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetThumbStyle(TLMDThumbStyle aValue);
	void __fastcall SetTickMarks(TLMDTickMarks aValue);
	void __fastcall SetTickStyle(TLMDTickStyle aValue);
	void __fastcall SetTrackBorderStyle(Lmdgraph::TLMDBorderStyle aValue);
	void __fastcall SetUseFocusColor(bool aValue);
	void __fastcall SetFillObject(Lmdfillobject::TLMDFillObject* aValue);
	HIDESBASE void __fastcall SetBoolean(bool aValue);
	Vcl::Graphics::TBitmap* __fastcall GetThumb(void);
	bool __fastcall IsCustom(void);
	void __fastcall SetUseGlobalTimer(const bool Value);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Message);
	
protected:
	System::Classes::TNotifyEvent FOnDrawFrame;
	int FMax;
	int FMin;
	int FLineSize;
	int FPageSize;
	int FPosition;
	int FTickLength;
	int FMargin;
	Lmdclass::TLMDTimer* FTimerId;
	TLMDTickStyle FTickStyle;
	TLMDTickMarks FTickMarks;
	int FTickGap;
	System::Uitypes::TColor FFocusColor;
	System::Uitypes::TColor FTickColor;
	bool FTrackTransparent;
	bool FUseFocusColor;
	System::Byte FDirection;
	TLMDTrackBarFocusStyle FFocusStyle;
	Lmdgraph::TLMDBorderStyle FTrackBorderStyle;
	int FTrackBorder;
	System::Uitypes::TColor FTrackColor;
	System::Uitypes::TColor FThumbColor;
	int FTrackWidth;
	System::Types::TRect FTrackRect;
	System::Types::TRect FBRect;
	System::Types::TRect FCRect;
	TLMDThumbStyle FThumbStyle;
	Vcl::Graphics::TBitmap* FThumb;
	Lmdfillobject::TLMDFillObject* FTrackFillObject;
	Lmdgraph::TLMDOrientation FOrientation;
	System::Types::TPoint FMousePos;
	bool FSliding;
	int FThumbHeight;
	int FThumbWidth;
	int fh;
	int fmyw;
	int fmyh;
	Vcl::Graphics::TBitmap* FBack;
	Vcl::Graphics::TBitmap* FBuff;
	System::Classes::TNotifyEvent FOnChange;
	TLMDDrawTickEvent FOnDrawTick;
	Vcl::Stdctrls::TScrollEvent FOnTrack;
	bool FUseGlobalTimer;
	void __fastcall CreateThumb(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	virtual bool __fastcall IsMouseOnTrack(const System::Types::TPoint &AMousePos);
	virtual void __fastcall DoThemeChanged(void);
	DYNAMIC bool __fastcall DoMouseWheelDown(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	virtual void __fastcall RestoreThumbBack(const System::Types::TRect &ABRect, Vcl::Graphics::TBitmap* const ABack);
	void __fastcall DrawFocus(const System::Types::TRect &aRect);
	virtual void __fastcall DrawThumb(int fpos, System::Types::TRect &ABRect, Vcl::Graphics::TBitmap* &ABack, bool AActiveSlider);
	virtual void __fastcall TimerExpired(System::TObject* Sender);
	virtual void __fastcall DrawTicks(void);
	DYNAMIC void __fastcall DoDrawTick(Vcl::Graphics::TCanvas* aCanvas, int aValue, const System::Types::TPoint &pos);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	virtual int __fastcall GetPosition(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall CalcThumbRect(int fpos, System::Types::TRect &ABRect);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int x, int y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int x, int y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall PaintPos(void);
	virtual void __fastcall Paint(void);
	void __fastcall PrepareBuff(void);
	__property System::Classes::TNotifyEvent OnDrawFrame = {read=FOnDrawFrame, write=FOnDrawFrame};
	
public:
	__fastcall virtual TLMDCustomTrackBar(System::Classes::TComponent* AOwner);
	void __fastcall Init(void);
	__fastcall virtual ~TLMDCustomTrackBar(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual bool __fastcall isTransparentSet(void);
	void __fastcall SetRange(int MinValue, int MaxValue);
	__property int Position = {read=FPosition, write=SetPosition, nodefault};
	__property CtlXP = {default=0};
	
__published:
	__property System::Uitypes::TColor FocusColor = {read=FFocusColor, write=SetColor, index=3, default=8421504};
	__property TLMDTrackBarFocusStyle FocusStyle = {read=FFocusStyle, write=FFocusStyle, default=0};
	__property bool UseFocusColor = {read=FUseFocusColor, write=SetUseFocusColor, default=0};
	__property int MaxValue = {read=FMax, write=SetInteger, index=0, default=10};
	__property int MinValue = {read=FMin, write=SetInteger, index=1, default=0};
	__property int Margin = {read=FMargin, write=SetInteger, index=7, default=1};
	__property int LineSize = {read=FLineSize, write=SetInteger, index=2, default=1};
	__property int PageSize = {read=FPageSize, write=SetInteger, index=3, default=2};
	__property Lmdgraph::TLMDOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property Vcl::Graphics::TBitmap* Thumb = {read=GetThumb, write=SetThumb, stored=IsCustom};
	__property System::Uitypes::TColor ThumbColor = {read=FThumbColor, write=SetColor, index=0, default=-16777201};
	__property TLMDThumbStyle ThumbStyle = {read=FThumbStyle, write=SetThumbStyle, default=0};
	__property System::Uitypes::TColor TickColor = {read=FTickColor, write=SetColor, index=2, default=0};
	__property int TickGap = {read=FTickGap, write=SetInteger, index=8, default=-1};
	__property int TickLength = {read=FTickLength, write=SetInteger, index=6, default=6};
	__property TLMDTickMarks TickMarks = {read=FTickMarks, write=SetTickMarks, default=1};
	__property TLMDTickStyle TickStyle = {read=FTickStyle, write=SetTickStyle, default=0};
	__property Lmdgraph::TLMDBorderStyle TrackBorderStyle = {read=FTrackBorderStyle, write=SetTrackBorderStyle, default=7};
	__property int TrackBorder = {read=FTrackBorder, write=SetInteger, index=4, default=0};
	__property System::Uitypes::TColor TrackColor = {read=FTrackColor, write=SetColor, index=1, default=16777215};
	__property int TrackWidth = {read=FTrackWidth, write=SetInteger, index=5, default=10};
	__property Lmdfillobject::TLMDFillObject* TrackFillObject = {read=FTrackFillObject, write=SetFillObject};
	__property bool TrackTransparent = {read=FTrackTransparent, write=SetBoolean, default=0};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TLMDDrawTickEvent OnDrawTick = {read=FOnDrawTick, write=FOnDrawTick};
	__property Vcl::Stdctrls::TScrollEvent OnTrack = {read=FOnTrack, write=FOnTrack};
	__property About = {default=0};
	__property Align = {default=0};
	__property BackFX;
	__property Color = {default=-16777201};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property ParentBackground = {default=0};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Transparent = {default=0};
	__property bool UseGlobalTimer = {read=FUseGlobalTimer, write=SetUseGlobalTimer, default=0};
	__property ThemeMode = {default=0};
	__property ThemeGlobalMode = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheel;
	__property OnStartDrag;
	__property OnContextPopup;
	__property OnMouseActivate;
	__property Anchors = {default=3};
	__property DragKind = {default=0};
	__property Constraints;
	__property OnEndDock;
	__property OnStartDock;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomTrackBar(HWND ParentWindow) : Lmdcustompanel::TLMDCustomPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomtrackbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMTRACKBAR)
using namespace Lmdcustomtrackbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomtrackbarHPP
