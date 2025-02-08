// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolUtils.pas' rev: 5.00

#ifndef CoolUtilsHPP
#define CoolUtilsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ImgList.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <FileCtrl.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Coolutils
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TShadowPosition { spLeftTop, spLeftBottom, spRightBottom, spRightTop };
#pragma option pop

#pragma option push -b-
enum TBevelStyleEx { bsBevelBoth, bsBevelOnlyImage, bsBevelOnlyText };
#pragma option pop

typedef void __fastcall (__closure *TWinMessageEvent)(System::TObject* Sender, Messages::TMessage &Msg
	, bool &Handled);

class DELPHICLASS TWndHook;
class PASCALIMPLEMENTATION TWndHook : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	bool FActive;
	Controls::TWinControl* FWinControl;
	TWinMessageEvent FOnBeforeMessage;
	TWinMessageEvent FOnAfterMessage;
	Classes::TNotifyEvent FOnChangeWinControl;
	void __fastcall SetActive(bool Value);
	unsigned __fastcall GetHandle(void);
	void __fastcall SetWinControl(Controls::TWinControl* Value);
	
protected:
	void *FNewProc;
	void *FDefProc;
	virtual void __fastcall HookWnd(unsigned AHandle);
	virtual void __fastcall UnhookWnd(unsigned AHandle);
	virtual void __fastcall UnhookWndEx(unsigned AHandle);
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	virtual void __fastcall RehookWnd(void);
	__fastcall virtual TWndHook(Classes::TComponent* AOwner);
	__fastcall virtual ~TWndHook(void);
	
__published:
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property Controls::TWinControl* WinControl = {read=FWinControl, write=SetWinControl};
	__property unsigned Handle = {read=GetHandle, nodefault};
	__property TWinMessageEvent OnBeforeMessage = {read=FOnBeforeMessage, write=FOnBeforeMessage};
	__property TWinMessageEvent OnAfterMessage = {read=FOnAfterMessage, write=FOnAfterMessage};
	__property Classes::TNotifyEvent OnChangeWinControl = {read=FOnChangeWinControl, write=FOnChangeWinControl
		};
};


class DELPHICLASS TGlyphList;
class PASCALIMPLEMENTATION TGlyphList : public Controls::TImageList 
{
	typedef Controls::TImageList inherited;
	
private:
	Classes::TBits* Used;
	int FCount;
	int __fastcall AllocateIndex(void);
	
public:
	__fastcall TGlyphList(int AWidth, int AHeight);
	__fastcall virtual ~TGlyphList(void);
	HIDESBASE int __fastcall Add(Graphics::TBitmap* Image, Graphics::TBitmap* Mask);
	HIDESBASE int __fastcall AddMasked(Graphics::TBitmap* Image, Graphics::TColor MaskColor);
	HIDESBASE void __fastcall Delete(int Index);
	__property int Count = {read=FCount, nodefault};
public:
	#pragma option push -w-inl
	/* TCustomImageList.Create */ inline __fastcall virtual TGlyphList(Classes::TComponent* AOwner) : Controls::TImageList(
		AOwner) { }
	#pragma option pop
	
};


class DELPHICLASS TGlyphCache;
class PASCALIMPLEMENTATION TGlyphCache : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Classes::TList* GlyphLists;
	
public:
	__fastcall TGlyphCache(void);
	__fastcall virtual ~TGlyphCache(void);
	TGlyphList* __fastcall GetList(int AWidth, int AHeight);
	void __fastcall ReturnList(TGlyphList* List);
	bool __fastcall Empty(void);
};


class DELPHICLASS TGlyph;
class PASCALIMPLEMENTATION TGlyph : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Graphics::TBitmap* FOriginal;
	TGlyphList* FGlyphList;
	int FIndexs[2];
	Graphics::TColor FTransparentColor;
	Buttons::TNumGlyphs FNumGlyphs;
	Classes::TNotifyEvent FOnChange;
	bool FSimpleCaption;
	void __fastcall GlyphChanged(System::TObject* Sender);
	void __fastcall SetGlyph(Graphics::TBitmap* Value);
	void __fastcall SetNumGlyphs(Buttons::TNumGlyphs Value);
	void __fastcall Invalidate(void);
	int __fastcall CreateGlyph(bool State);
	void __fastcall CalcButtonLayout(Graphics::TCanvas* Canvas, const Windows::TRect &Client, const Windows::TPoint 
		&Offset, const AnsiString Caption, Buttons::TButtonLayout Layout, int Margin, int Spacing, Windows::TPoint 
		&GlyphPos, Windows::TRect &TextBounds, int BiDiFlags);
	
public:
	__fastcall TGlyph(void);
	__fastcall virtual ~TGlyph(void);
	void __fastcall DrawCaption(Graphics::TCanvas* Canvas, const AnsiString Caption, const Windows::TRect 
		&TextBounds, bool State, bool SimpleView, TShadowPosition ShadowPos, Graphics::TColor ShadowColor, 
		int ShadowSize, int BiDiFlags);
	void __fastcall DrawImage(Graphics::TCanvas* Canvas, const Windows::TPoint &GlyphPos, bool State, bool 
		Transparent, Graphics::TColor BkColor);
	void __fastcall DrawImageEx(Graphics::TCanvas* Canvas, const Windows::TRect &Client, const Windows::TPoint 
		&Offset, const AnsiString Caption, Buttons::TButtonLayout Layout, int Margin, int Spacing, bool State
		, bool Transparent, Graphics::TColor BkColor, int BiDiFlags);
	void __fastcall DrawBevels(Graphics::TCanvas* Canvas, const Windows::TRect &Client, const Windows::TPoint 
		&Offset, const AnsiString Caption, Buttons::TButtonLayout Layout, int Margin, int Spacing, Controls::TBevelCut 
		BevelInner, Controls::TBevelCut BevelOuter, TBevelStyleEx BevelStyle, int BiDiFlags);
	Windows::TRect __fastcall Draw(Graphics::TCanvas* Canvas, const Windows::TRect &Client, const Windows::TPoint 
		&Offset, const AnsiString Caption, Buttons::TButtonLayout Layout, int Margin, int Spacing, bool State
		, bool Transparent, Graphics::TColor BkColor, bool SimpleView, TShadowPosition ShadowPos, Graphics::TColor 
		ShadowColor, int ShadowSize, int BiDiFlags);
	Windows::TRect __fastcall DrawFast(Graphics::TCanvas* Canvas, const Windows::TRect &Client, const Windows::TPoint 
		&Offset, const AnsiString Caption, Buttons::TButtonLayout Layout, int Margin, int Spacing, bool State
		, bool Transparent, Graphics::TColor BkColor, bool SimpleView, TShadowPosition ShadowPos, Graphics::TColor 
		ShadowColor, int ShadowSize, int BiDiFlags);
	__property Graphics::TBitmap* Glyph = {read=FOriginal, write=SetGlyph};
	__property Buttons::TNumGlyphs NumGlyphs = {read=FNumGlyphs, write=SetNumGlyphs, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property bool SimpleCaption = {read=FSimpleCaption, write=FSimpleCaption, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall DelphiRunning(void);
extern PACKAGE bool __fastcall DelphiRunningByExeName(AnsiString AFileName);
extern PACKAGE void __fastcall DrawWallpaper(HDC DC, Graphics::TBitmap* Bitmap, const Windows::TRect 
	&Recty, bool IsStretch, int Mode);
extern PACKAGE void __fastcall DrawWallpaperEx(HDC DC, Graphics::TBitmap* Bitmap, const Windows::TRect 
	&Recty, const Windows::TRect &SubRect, bool IsStretch, int Mode);
extern PACKAGE void __fastcall StretchDrawWallpaper(HDC DC, Graphics::TBitmap* Bitmap, const Windows::TRect 
	&DCRecty, const Windows::TRect &ImgRecty, int Mode);
extern PACKAGE bool __fastcall InvalidateRectEx(unsigned Handle, const Windows::TRect &R, bool bErase
	);
extern PACKAGE void __fastcall PaintBackground(Controls::TWinControl* Control, HDC DC, bool DoParent
	);
extern PACKAGE void __fastcall PaintBackgroundEx(Controls::TWinControl* Control, HDC DC, const Windows::TRect 
	&R, bool DoParent);
extern PACKAGE void __fastcall PaintBackgroundCombineRgn(Controls::TWinControl* Control, HDC DC, const 
	Windows::TRect &R, const Windows::TRect &SubR, int CombineMode, bool DoParent);
extern PACKAGE Graphics::TColor __fastcall GetUnderlyingColor(Controls::TWinControl* Control, const 
	Windows::TPoint &Pt);
extern PACKAGE bool __fastcall CheckTTFont(AnsiString FontName);
extern PACKAGE void __fastcall InflateRectEx(Windows::TRect &R, int lOffset, int tOffset, int rOffset
	, int bOffset);
extern PACKAGE void __fastcall FillGradientRect(HDC DC, const Windows::TRect &Rect, Graphics::TColor 
	BeginColor, Graphics::TColor EndColor, int Colors, bool LeftToRight);
extern PACKAGE void __fastcall SetAngledFont(const Graphics::TFont* AFont, int ADegree);
extern PACKAGE void __fastcall GetBitmapFromIcon(const Graphics::TBitmap* Result, Graphics::TIcon* Icon
	, Graphics::TColor BgColor);
extern PACKAGE int __fastcall GetMenuDefaultFont(const Graphics::TFont* AFont);
extern PACKAGE Graphics::TColor __fastcall GetInvertedColor(Graphics::TColor FColor);
extern PACKAGE void __fastcall CreateMonoBitmap(const Graphics::TBitmap* Result, Graphics::TColor TransparentColor
	, Graphics::TColor BrushColor, int State, bool OldStyle);
extern PACKAGE void __fastcall DrawRoundedEdge(Graphics::TCanvas* Canvas, const Windows::TRect &Recty
	, Graphics::TColor BgColor, Graphics::TColor SdColor, Graphics::TColor BdColor, int Rounded, int AInnerEdges
	, int AOuterEdges);
extern PACKAGE void __fastcall SetJustify(Menus::TMenu* Menu, Menus::TMenuItem* MenuItem, Byte Justify
	);
extern PACKAGE int __fastcall GetSysColorsNumber(Graphics::TCanvas* Canvas);
extern PACKAGE bool __fastcall PointsFakeEqual(const Windows::TPoint &APoint1, const Windows::TPoint 
	&APoint2, int Offset);
extern PACKAGE unsigned __fastcall LoadBitmapIcon(unsigned AInstance, char * AResourceName);
extern PACKAGE unsigned __fastcall OpenBitmapIcon(AnsiString FileName);
extern PACKAGE void __fastcall Delay(unsigned msecs);
extern PACKAGE void __fastcall BitmapRotate(const Graphics::TBitmap* ABitmap, int AAngle);
extern PACKAGE bool __fastcall KeyboardChanged(const Byte * Keys);
extern PACKAGE bool __fastcall Popup(Controls::TWinControl* WinControl, Menus::TPopupMenu* Menu);
extern PACKAGE bool __fastcall PopupEx(Controls::TWinControl* WinControl, Menus::TPopupMenu* Menu, int 
	X, int Y);
extern PACKAGE Menus::TMenuItem* __fastcall NewItemEx(const AnsiString ACaption, Classes::TShortCut 
	AShortCut, bool ARadioItem, bool AChecked, bool AEnabled, Classes::TNotifyEvent AOnClick, Word hCtx
	, Menus::TMenuBreak ABreak, const AnsiString AName);
extern PACKAGE int __fastcall MinVal(int A, int B);
extern PACKAGE int __fastcall MaxVal(int A, int B);
extern PACKAGE bool __fastcall FakeStartBtnClick(void);
extern PACKAGE AnsiString __fastcall BoolToStr(bool Value);
extern PACKAGE bool __fastcall StrToBool(AnsiString Value);
extern PACKAGE int __fastcall RPos(AnsiString SubStr, AnsiString S);
extern PACKAGE AnsiString __fastcall GetParentFolder(AnsiString FolderName);
extern PACKAGE void __fastcall Draw3DText(HDC DC, Windows::TRect &R, TShadowPosition ShadowPos, char * 
	Text, int Flags, Graphics::TColor ColorText, Graphics::TColor ColorShadow, int ShadowSize);
extern PACKAGE void __fastcall TransparentStretchBltEx(HDC DestDC, HDC SourceDC, const Windows::TRect 
	&DestRect, const Windows::TRect &SourceRect, Graphics::TColor TrColor);
extern PACKAGE int __fastcall PredEx(int Value, int Amount);
extern PACKAGE int __fastcall SuccEx(int Value, int Amount);
extern PACKAGE bool __fastcall DesignTime(Classes::TComponent* Component);
extern PACKAGE void __fastcall PaintPatternBackground(Graphics::TCanvas* Canvas, const Windows::TRect 
	&R);
extern PACKAGE void __fastcall OffsetPoint(Windows::TPoint &P, int X, int Y);
extern PACKAGE Controls::TWinControl* __fastcall TrControl(Controls::TWinControl* SelfControl, Byte 
	TransparencyLevel);
extern PACKAGE bool __fastcall MouseInCtl(Controls::TControl* Control);
extern PACKAGE void __fastcall ForceMouseLeaveMessage(Controls::TControl* Control, unsigned CheckTimeout
	);
extern PACKAGE Classes::TShiftState __fastcall CurrentShiftState(void);
extern PACKAGE Classes::TStringList* __fastcall GetFileDirList(AnsiString FDirectory, AnsiString Filter
	, int Attr);

}	/* namespace Coolutils */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Coolutils;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolUtils
