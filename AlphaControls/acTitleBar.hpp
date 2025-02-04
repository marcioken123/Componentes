// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acTitleBar.pas' rev: 27.00 (Windows)

#ifndef ActitlebarHPP
#define ActitlebarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Actitlebar
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TacTitleBarItem;
typedef void __fastcall (__closure *TacDrawItemEvent)(TacTitleBarItem* Item, const System::Types::TRect &R, Vcl::Graphics::TBitmap* Bmp, bool NoAlpha);

class DELPHICLASS TacItemAnimation;
class PASCALIMPLEMENTATION TacItemAnimation : public Vcl::Extctrls::TTimer
{
	typedef Vcl::Extctrls::TTimer inherited;
	
public:
	HWND FormHandle;
	TacTitleBarItem* Item;
	int CurrentLevel;
	int CurrentState;
	bool ToShow;
	int MaxIterations;
	Vcl::Forms::TForm* AForm;
	Vcl::Forms::TForm* OldForm;
	Vcl::Graphics::TBitmap* NewBmp;
	__fastcall virtual TacItemAnimation(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TacItemAnimation(void);
	System::Types::TRect __fastcall GetFormBounds(void);
	int __fastcall Offset(void);
	int __fastcall Step(void);
	void __fastcall MakeForm(void);
	void __fastcall UpdateForm(int Blend);
	void __fastcall StartAnimation(int NewState, bool Show);
	void __fastcall ChangeState(int NewState, bool Show);
	void __fastcall MakeImg(void);
	void __fastcall CheckMouseLeave(void);
	void __fastcall OnAnimTimer(System::TObject* Sender);
};


class DELPHICLASS TacFontData;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacFontData : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Vcl::Graphics::TFont* FFont;
	HWND WndHandle;
	bool FUseSysColor;
	bool FUseSysSize;
	bool FUseSysStyle;
	bool FUseSysFontName;
	bool FUseSysGlowing;
	int FGlowSize;
	System::Uitypes::TColor FGlowColor;
	void __fastcall SetBool(const int Index, const bool Value);
	bool __fastcall GetBool(const int Index);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetGlowSize(const int Value);
	void __fastcall SetGlowColor(const System::Uitypes::TColor Value);
	
public:
	Vcl::Graphics::TFont* UsedFont;
	Vcl::Graphics::TBitmap* GlowMask;
	__fastcall TacFontData(void);
	__fastcall virtual ~TacFontData(void);
	void __fastcall Invalidate(void);
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property System::Uitypes::TColor GlowColor = {read=FGlowColor, write=SetGlowColor, default=8421504};
	__property int GlowSize = {read=FGlowSize, write=SetGlowSize, default=0};
	__property bool UseSysColor = {read=GetBool, write=SetBool, index=0, default=1};
	__property bool UseSysFontName = {read=GetBool, write=SetBool, index=1, default=1};
	__property bool UseSysGlowing = {read=GetBool, write=SetBool, index=2, default=1};
	__property bool UseSysSize = {read=GetBool, write=SetBool, index=3, default=1};
	__property bool UseSysStyle = {read=GetBool, write=SetBool, index=4, default=1};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TacBtnStyle : unsigned char { bsButton, bsMenu, bsTab, bsSpacing, bsInfo };

enum DECLSPEC_DENUM TacItemAlign : unsigned char { tbaLeft, tbaRight, tbaCenter, tbaCenterInSpace };

class PASCALIMPLEMENTATION TacTitleBarItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	Vcl::Graphics::TBitmap* FGlyph;
	bool FEnabled;
	System::UnicodeString FHint;
	bool FVisible;
	System::UnicodeString FCaption;
	int FGroupIndex;
	int FNumGlyphs;
	int FImageIndex;
	TacBtnStyle FStyle;
	TacItemAlign FAlign;
	Vcl::Controls::TMouseEvent FOnMouseUp;
	Vcl::Controls::TMouseEvent FOnMouseDown;
	System::Classes::TNotifyEvent FOnMouseLeave;
	System::Classes::TNotifyEvent FOnMouseEnter;
	int FHeight;
	int FWidth;
	bool FAutoSize;
	Vcl::Menus::TPopupMenu* FDropdownMenu;
	Vcl::Graphics::TBitmap* FDefaultMenuBtn;
	int FSpacing;
	TacFontData* FFontData;
	bool FShowHint;
	TacDrawItemEvent FOnDrawItem;
	bool FDroppedDown;
	System::Classes::TNotifyEvent FOnClick;
	System::Classes::TNotifyEvent FOnChanged;
	System::Types::TSize FContentSize;
	System::UnicodeString FSkinSection;
	int FHotImageIndex;
	int FDisabledImageIndex;
	int FPressedImageIndex;
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetName(const System::UnicodeString Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall OnGlyphChange(System::TObject* Sender);
	void __fastcall SetAlign(const TacItemAlign Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetGroupIndex(const int Value);
	void __fastcall SetNumGlyphs(const int Value);
	void __fastcall SetStyle(const TacBtnStyle Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetDown(const bool Value);
	void __fastcall SetSpacing(const int Value);
	void __fastcall SetState(const int Value);
	void __fastcall SetSkinSection(const System::UnicodeString Value);
	int __fastcall GetState(void);
	void __fastcall SetImageIndex(const int Index, const int Value);
	
protected:
	bool FDown;
	int FState;
	bool FPressed;
	
public:
	Vcl::Controls::THintWindow* HintWnd;
	System::Types::TRect Rect;
	System::TObject* *Data;
	TacItemAnimation* Timer;
	Vcl::Forms::TForm* ExtForm;
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	__fastcall virtual TacTitleBarItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TacTitleBarItem(void);
	void __fastcall InitFont(void);
	void __fastcall DoMouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall DoMouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall DoClick(void);
	HIDESBASE void __fastcall Changed(void);
	void __fastcall UpdateSize(bool ContentOnly = false);
	void __fastcall Invalidate(bool RecalcSize = false);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	int __fastcall IntXMargin(void);
	__property Vcl::Graphics::TBitmap* DefaultMenuBtn = {read=FDefaultMenuBtn};
	__property bool DroppedDown = {read=FDroppedDown, nodefault};
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, nodefault};
	__property System::Types::TSize ContentSize = {read=FContentSize};
	__property bool Pressed = {read=FPressed, nodefault};
	__property int State = {read=GetState, write=SetState, nodefault};
	__property TacDrawItemEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
	__property System::Classes::TNotifyEvent OnChanged = {read=FOnChanged, write=FOnChanged};
	
__published:
	__property TacItemAlign Align = {read=FAlign, write=SetAlign, default=0};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=1};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Vcl::Menus::TPopupMenu* DropdownMenu = {read=FDropdownMenu, write=FDropdownMenu};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property TacFontData* FontData = {read=FFontData, write=FFontData};
	__property Vcl::Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property int Height = {read=FHeight, write=SetHeight, default=18};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property int DisabledImageIndex = {read=FDisabledImageIndex, write=SetImageIndex, index=0, default=-1};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, index=1, default=-1};
	__property int HotImageIndex = {read=FHotImageIndex, write=SetImageIndex, index=2, default=-1};
	__property int PressedImageIndex = {read=FPressedImageIndex, write=SetImageIndex, index=3, default=-1};
	__property Index;
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property int NumGlyphs = {read=FNumGlyphs, write=SetNumGlyphs, default=1};
	__property bool ShowHint = {read=FShowHint, write=FShowHint, nodefault};
	__property System::UnicodeString SkinSection = {read=FSkinSection, write=SetSkinSection};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
	__property TacBtnStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int Width = {read=FWidth, write=SetWidth, default=22};
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property Vcl::Controls::TMouseEvent OnMouseDown = {read=FOnMouseDown, write=FOnMouseDown};
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Vcl::Controls::TMouseEvent OnMouseUp = {read=FOnMouseUp, write=FOnMouseUp};
};


class DELPHICLASS TacTitleItems;
class DELPHICLASS TsTitleBar;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacTitleItems : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TacTitleBarItem* operator[](int Index) { return Items[Index]; }
	
private:
	TsTitleBar* FOwner;
	HIDESBASE TacTitleBarItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TacTitleBarItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TacTitleItems(System::Classes::TPersistent* AOwner);
	__fastcall virtual ~TacTitleItems(void);
	HIDESBASE TacTitleBarItem* __fastcall Add(void);
	HIDESBASE TacTitleBarItem* __fastcall Insert(int Index);
	__property TacTitleBarItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TsTitleBar : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Vcl::Imglist::TChangeLink* FImageChangeLink;
	Vcl::Forms::TForm* Form;
	TacTitleItems* FItems;
	int FItemsSpacing;
	int FItemsMargin;
	System::Types::TRect FCaptionRect;
	int FLeftWidth;
	int FRightWidth;
	int FCenterWidth;
	int FCenterWidthS;
	Vcl::Imglist::TCustomImageList* FImages;
	bool FShowCaption;
	void __fastcall SetItems(TacTitleItems* const Value);
	void __fastcall SetItemsMargin(const int Value);
	void __fastcall SetItemsSpacing(const int Value);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetShowCaption(const bool Value);
	
protected:
	int FBarVCenter;
	System::Types::TRect FBarRect;
	int FFullRight;
	void __fastcall ImageListChange(System::TObject* Sender);
	
public:
	Vcl::Graphics::TBitmap* FDefaultMenuBtn;
	void __fastcall CalcSizes(void);
	__fastcall virtual TsTitleBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsTitleBar(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall Invalidate(void);
	__property System::Types::TRect BarRect = {read=FBarRect};
	__property System::Types::TRect CaptionRect = {read=FCaptionRect};
	__property int LeftWidth = {read=FLeftWidth, nodefault};
	__property int RightWidth = {read=FRightWidth, nodefault};
	
__published:
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property TacTitleItems* Items = {read=FItems, write=SetItems};
	__property int ItemsMargin = {read=FItemsMargin, write=SetItemsMargin, default=3};
	__property int ItemsSpacing = {read=FItemsSpacing, write=SetItemsSpacing, default=0};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
static const System::WideChar acDownChar = (System::WideChar)(0x75);
#define acDownFont L"Marlett"
extern DELPHI_PACKAGE void __fastcall StartItemAnimation(TacTitleBarItem* const Item, const int Iterations, const bool Show, Vcl::Forms::TForm* ExtendedForm = (Vcl::Forms::TForm*)(0x0));
extern DELPHI_PACKAGE void __fastcall ShowHintWnd(TacTitleBarItem* Item);
extern DELPHI_PACKAGE void __fastcall HideHintWnd(TacTitleBarItem* Item);
extern DELPHI_PACKAGE void __fastcall PaintItemNoAlpha(Vcl::Graphics::TBitmap* const DstBmp, Vcl::Graphics::TBitmap* const SrcBmp, const System::Types::TRect &DstRect, const System::Types::TRect &SrcRect, const System::Types::TRect &BorderWidths);
}	/* namespace Actitlebar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACTITLEBAR)
using namespace Actitlebar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ActitlebarHPP
