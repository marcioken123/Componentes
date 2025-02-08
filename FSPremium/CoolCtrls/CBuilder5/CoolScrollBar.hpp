// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolScrollbar.pas' rev: 5.00

#ifndef CoolScrollbarHPP
#define CoolScrollbarHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <CoolUtils.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <CoolCtrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
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

namespace Coolscrollbar
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TDrawOption { doGlyphUpTransparent, doGlyphDownTransparent, doGlyphThumbTransparent };
#pragma option pop

typedef Set<TDrawOption, doGlyphUpTransparent, doGlyphThumbTransparent>  TDrawOptions;

class DELPHICLASS TCoolScrollbar;
class PASCALIMPLEMENTATION TCoolScrollbar : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	Windows::TRect FRulesRect;
	Windows::TRect FUpBtnRect;
	Windows::TRect FDnBtnRect;
	Windows::TRect FThumbRect;
	Graphics::TBitmap* FWallpaper;
	bool FButtonUpVisible;
	bool FButtonDownVisible;
	Graphics::TBitmap* FButtonDownGlyph;
	Graphics::TBitmap* FButtonUpGlyph;
	Graphics::TBitmap* FThumbGlyph;
	int FMin;
	int FMax;
	int FPosition;
	Forms::TScrollBarInc FLargeChange;
	Forms::TScrollBarInc FSmallChange;
	Forms::TScrollBarKind FKind;
	Classes::TNotifyEvent FOnChange;
	Stdctrls::TScrollEvent FOnScroll;
	int FPageSize;
	bool FStretchThumb;
	bool FProportionalBtn;
	TDrawOptions FDrawOptions;
	Coolctrls::TCoolOptions FOptions;
	Coolctrls::TCoolChangeLink* FCoolImagesChangeLink;
	Coolctrls::TCoolImages* FCoolImages;
	int FidWallpaper;
	void __fastcall SetCoolImages(Coolctrls::TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetFramed(const bool Value);
	void __fastcall SetButtonDownVisible(const bool Value);
	void __fastcall SetButtonUpVisible(const bool Value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall SetButtonDownGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetButtonUpGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetThumbGlyph(const Graphics::TBitmap* Value);
	bool __fastcall GetTransparent(void);
	bool __fastcall GetFramed(void);
	void __fastcall SetMax(const int Value);
	void __fastcall SetMin(const int Value);
	void __fastcall SetKind(const Forms::TScrollBarKind Value);
	void __fastcall SetPageSize(const int Value);
	void __fastcall SetStretchThumb(const bool Value);
	void __fastcall SetProportionalBtn(const bool Value);
	void __fastcall SetPosition(const int Value);
	void __fastcall SetDrawOptions(const TDrawOptions Value);
	void __fastcall SetOptions(Coolctrls::TCoolOptions Value);
	bool __fastcall IsWallpaperAssigned(void);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	
protected:
	int BtnLen;
	int ScrollLen;
	int FMousePos;
	double FThumbLen;
	int FPosX;
	int FPosY;
	bool FReadOnly;
	bool FRightOfThumbDn;
	bool FLeftOfThumbDn;
	bool FThumbBtnDn;
	bool FLeftBtnDn;
	bool FRightBtnDn;
	bool FMouseDn;
	bool FMouseIn;
	bool FFocused;
	Graphics::TBitmap* FButtonUp;
	Graphics::TBitmap* FButtonDown;
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall DrawButtonUp(bool Down);
	void __fastcall DrawButtonDown(bool Down);
	void __fastcall DrawThumb(void);
	void __fastcall DrawFrame(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Btn, Classes::TShiftState Shift, int X, int 
		Y);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall CNKeyDown(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CNKeyUp(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TMessage &Message);
	bool __fastcall PointInsideRect(const Windows::TRect &Rc, int X, int Y);
	void __fastcall RecalcRect(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall Scroll(Stdctrls::TScrollCode ScrollCode, int &ScrollPos);
	virtual void __fastcall SetEnabled(bool Value);
	void __fastcall TimerEvent(System::TObject* Sender);
	
public:
	__fastcall virtual TCoolScrollbar(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolScrollbar(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Coolctrls::TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property TDrawOptions DrawOptions = {read=FDrawOptions, write=SetDrawOptions, nodefault};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property Coolctrls::TCoolOptions Options = {read=FOptions, write=SetOptions, default=4160};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property Graphics::TBitmap* ThumbGlyph = {read=FThumbGlyph, write=SetThumbGlyph};
	__property Graphics::TBitmap* ButtonUpGlyph = {read=FButtonUpGlyph, write=SetButtonUpGlyph};
	__property Graphics::TBitmap* ButtonDownGlyph = {read=FButtonDownGlyph, write=SetButtonDownGlyph};
	__property bool Framed = {read=GetFramed, write=SetFramed, default=1};
	__property bool Transparent = {read=GetTransparent, write=SetTransparent, default=0};
	__property bool ButtonUpVisible = {read=FButtonUpVisible, write=SetButtonUpVisible, default=1};
	__property bool ButtonDownVisible = {read=FButtonDownVisible, write=SetButtonDownVisible, default=1
		};
	__property bool StretchThumb = {read=FStretchThumb, write=SetStretchThumb, default=1};
	__property bool ProportionalBtn = {read=FProportionalBtn, write=SetProportionalBtn, nodefault};
	__property Align ;
	__property Anchors ;
	__property BiDiMode ;
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property Forms::TScrollBarInc LargeChange = {read=FLargeChange, write=FLargeChange, default=1};
	__property Forms::TScrollBarKind Kind = {read=FKind, write=SetKind, default=0};
	__property int Max = {read=FMax, write=SetMax, default=100};
	__property int Min = {read=FMin, write=SetMin, default=0};
	__property int PageSize = {read=FPageSize, write=SetPageSize, nodefault};
	__property ParentBiDiMode ;
	__property ParentCtl3D ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property int Position = {read=FPosition, write=SetPosition, default=0};
	__property ShowHint ;
	__property Forms::TScrollBarInc SmallChange = {read=FSmallChange, write=FSmallChange, default=1};
	__property TabOrder ;
	__property TabStop ;
	__property Visible ;
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property OnContextPopUp ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property Stdctrls::TScrollEvent OnScroll = {read=FOnScroll, write=FOnScroll};
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolScrollbar(HWND ParentWindow) : Controls::TCustomControl(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TDBCoolScrollbar;
class DELPHICLASS TSBDataLink;
class PASCALIMPLEMENTATION TSBDataLink : public Db::TDataLink 
{
	typedef Db::TDataLink inherited;
	
private:
	TDBCoolScrollbar* FNavigator;
	
protected:
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall ActiveChanged(void);
	
public:
	__fastcall TSBDataLink(TDBCoolScrollbar* ANav);
	__fastcall virtual ~TSBDataLink(void);
};


class PASCALIMPLEMENTATION TDBCoolScrollbar : public TCoolScrollbar 
{
	typedef TCoolScrollbar inherited;
	
private:
	TSBDataLink* FDataLink;
	Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	void __fastcall DataChanged(void);
	void __fastcall ActiveChanged(void);
	DYNAMIC void __fastcall Scroll(Stdctrls::TScrollCode ScrollCode, int &ScrollPos);
	
public:
	__fastcall virtual TDBCoolScrollbar(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBCoolScrollbar(void);
	
__published:
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TDBCoolScrollbar(HWND ParentWindow) : TCoolScrollbar(
		ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Coolscrollbar */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Coolscrollbar;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolScrollbar
