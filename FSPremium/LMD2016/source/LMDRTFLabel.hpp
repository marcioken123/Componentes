// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFLabel.pas' rev: 31.00 (Windows)

#ifndef LmdrtflabelHPP
#define LmdrtflabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Themes.hpp>
#include <LMDTypes.hpp>
#include <LMDRTFBase.hpp>
#include <LMDRTFStorage.hpp>
#include <LMDRTFRichEdit.hpp>
#include <LMDRTFHyperText.hpp>
#include <LMDBaseControl.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtflabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRTFBevel;
class DELPHICLASS TLMDImageRichEdit;
class DELPHICLASS TLMDCustomRichLabel;
class DELPHICLASS TLMDRichLabel;
class DELPHICLASS TLMDCustomRichScrollText;
class DELPHICLASS TLMDRichScrollText;
class DELPHICLASS TLMDCustomRichScrollBox;
class DELPHICLASS TLMDRichScrollBar;
class DELPHICLASS TLMDRichScrollBox;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDRTFFrameSide : unsigned char { fsLeft, fsTop, fsRight, fsBottom };

typedef System::Set<TLMDRTFFrameSide, TLMDRTFFrameSide::fsLeft, TLMDRTFFrameSide::fsBottom> TLMDRTFFrameSides;

enum DECLSPEC_DENUM TLMDRTFBevelStyle : unsigned char { bvNone, bvLovered, bvRaised };

class PASCALIMPLEMENTATION TLMDRTFBevel : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Classes::TNotifyEvent FOnChange;
	TLMDRTFBevelStyle FStyleOuter;
	TLMDRTFBevelStyle FStyleInner;
	TLMDRTFFrameSides FBorderSides;
	void __fastcall SetBorderSides(const TLMDRTFFrameSides Value);
	void __fastcall SetStyleInner(const TLMDRTFBevelStyle Value);
	void __fastcall SetStyleOuter(const TLMDRTFBevelStyle Value);
	
protected:
	DYNAMIC void __fastcall Change(void);
	
public:
	__fastcall TLMDRTFBevel(void);
	void __fastcall PaintBevel(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aClientRect, bool aTransparent, int SB);
	System::Types::TRect __fastcall ClientRect(const System::Types::TRect &aRect, int SB);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property TLMDRTFFrameSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property TLMDRTFBevelStyle StyleInner = {read=FStyleInner, write=SetStyleInner, default=0};
	__property TLMDRTFBevelStyle StyleOuter = {read=FStyleOuter, write=SetStyleOuter, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDRTFBevel(void) { }
	
};


enum DECLSPEC_DENUM TLMDRTFScrollStyle : unsigned char { ssLoop, ssLoopReverse, ssOnce };

enum DECLSPEC_DENUM TLMDRTFScrollDirection : unsigned char { sdBottomToTop, sdLeftToRight, sdRightToLeft, sdTopToBottom };

class PASCALIMPLEMENTATION TLMDImageRichEdit : public Lmdrtfrichedit::TLMDRichEdit
{
	typedef Lmdrtfrichedit::TLMDRichEdit inherited;
	
private:
	System::Uitypes::TColor FBackColor;
	
protected:
	virtual System::Uitypes::TColor __fastcall GetThemedBkColor(void);
	
public:
	__fastcall TLMDImageRichEdit(System::Uitypes::TColor ABackColor);
public:
	/* TLMDCustomRichEdit.Destroy */ inline __fastcall virtual ~TLMDImageRichEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDImageRichEdit(HWND ParentWindow) : Lmdrtfrichedit::TLMDRichEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomRichLabel : public Lmdrtfbase::TLMDRichGraphicControl
{
	typedef Lmdrtfbase::TLMDRichGraphicControl inherited;
	
private:
	System::Classes::TStrings* FLines;
	bool FTransparent;
	bool FAutoURLDetect;
	bool FAutoURLPopup;
	Lmdrtfstorage::TLMDRichStorage* FRichStorage;
	int FRichStorageItem;
	Lmdrtfstorage::TLMDRTFChangeLink* FStorageLink;
	Lmdrtfbase::TLMDRichURLClickEvent FOnURLClick;
	Lmdrtfbase::TLMDRichURLClickEvent FOnLinkClick;
	bool FAllowObjects;
	TLMDRTFBevel* FBevel;
	bool FWordWrap;
	Lmdrtfhypertext::TLMDRichHyperText* FHyperText;
	Lmdrtfhypertext::TLMDRichHyperLinks* FLinkStorage;
	bool FAlphaBlend;
	System::Byte FAlphaBlendValue;
	Vcl::Menus::TPopupMenu* FPopupMenu;
	void __fastcall SetLines(System::Classes::TStrings* const Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetAutoURLDetect(const bool Value);
	void __fastcall SetStorage(Lmdrtfstorage::TLMDRichStorage* const Value);
	void __fastcall SetStorageItem(const int Value);
	void __fastcall UpdateFromStorage(void);
	void __fastcall LinesChanged(System::TObject* Sender);
	void __fastcall BevelChanged(System::TObject* Sender);
	void __fastcall StorageDataChanged(System::TObject* Sender);
	void __fastcall SetAllowObjects(const bool Value);
	bool __fastcall IsLinesStored(void);
	void __fastcall SetBevel(TLMDRTFBevel* const Value);
	void __fastcall SetWordWrap(const bool Value);
	bool __fastcall IsLink(int XPos, int YPos);
	bool __fastcall IsURL(const System::UnicodeString aText);
	void __fastcall DoLinkClick(int XPos, int YPos, System::Uitypes::TMouseButton amButton);
	void __fastcall MarkRichEdit(Lmdrtfrichedit::TLMDRichEdit* aEditor);
	void __fastcall SetAlphaBlend(const bool Value);
	void __fastcall SetAlphaBlendValue(const System::Byte Value);
	bool __fastcall IsValidRichStorageItem(void);
	void __fastcall PopupItemClick(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Winapi::Messages::TWMMouse &Message);
	MESSAGE void __fastcall CMThemeChanged(Winapi::Messages::TMessage &Message);
	
protected:
	System::Uitypes::TCursor FCursor;
	Vcl::Graphics::TBitmap* FLinkmap;
	Vcl::Graphics::TBitmap* FSourceBitmap;
	Vcl::Graphics::TBitmap* FSourceLinkmap;
	int FVSBMode;
	int FDeltaX;
	int FDeltaY;
	virtual int __fastcall ImageWidth(void);
	virtual int __fastcall ImageHeight(void);
	virtual void __fastcall UpdateImage(void);
	virtual void __fastcall Paint(void);
	System::Uitypes::TColor __fastcall GetThemedBkColor(void);
	DYNAMIC void __fastcall URLClick(const System::UnicodeString URLText, System::Uitypes::TMouseButton Button);
	DYNAMIC void __fastcall LinkClick(const System::UnicodeString LinkText, System::Uitypes::TMouseButton Button);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall LoadTextProperty(System::Classes::TReader* Reader);
	void __fastcall LoadLinkProperty(System::Classes::TReader* Reader);
	void __fastcall LoadStorageIndexProperty(System::Classes::TReader* Reader);
	virtual void __fastcall SetOffset(int aDeltaX, int aDeltaY);
	void __fastcall SetStartDelta(void);
	bool __fastcall GetLinkIndex(int XPos, int YPos, int &Index);
	
public:
	__fastcall virtual TLMDCustomRichLabel(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomRichLabel(void);
	__property bool AllowObjects = {read=FAllowObjects, write=SetAllowObjects, default=0};
	__property bool AlphaBlend = {read=FAlphaBlend, write=SetAlphaBlend, default=0};
	__property System::Byte AlphaBlendValue = {read=FAlphaBlendValue, write=SetAlphaBlendValue, default=255};
	__property bool AutoURLDetect = {read=FAutoURLDetect, write=SetAutoURLDetect, default=1};
	__property bool AutoURLPopup = {read=FAutoURLPopup, write=FAutoURLPopup, default=1};
	__property TLMDRTFBevel* Bevel = {read=FBevel, write=SetBevel};
	__property System::Classes::TStrings* Lines = {read=FLines, write=SetLines, stored=IsLinesStored};
	__property Lmdrtfstorage::TLMDRichStorage* RichStorage = {read=FRichStorage, write=SetStorage};
	__property int RichStorageItem = {read=FRichStorageItem, write=SetStorageItem, default=-1};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=1};
	__property Lmdrtfbase::TLMDRichURLClickEvent OnURLClick = {read=FOnURLClick, write=FOnURLClick};
	__property Lmdrtfbase::TLMDRichURLClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
};


class PASCALIMPLEMENTATION TLMDRichLabel : public TLMDCustomRichLabel
{
	typedef TLMDCustomRichLabel inherited;
	
__published:
	__property AutoURLDetect = {default=1};
	__property AutoURLPopup = {default=1};
	__property AllowObjects = {default=0};
	__property AlphaBlend = {default=0};
	__property AlphaBlendValue = {default=255};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Bevel;
	__property BiDiMode;
	__property Cursor = {default=0};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Hint = {default=0};
	__property Font;
	__property Lines;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property RichStorage;
	__property RichStorageItem = {default=-1};
	__property ShowHint;
	__property Transparent = {default=0};
	__property WordWrap = {default=1};
	__property Visible = {default=1};
	__property OnURLClick;
	__property OnLinkClick;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TLMDCustomRichLabel.Create */ inline __fastcall virtual TLMDRichLabel(System::Classes::TComponent* aOwner) : TLMDCustomRichLabel(aOwner) { }
	/* TLMDCustomRichLabel.Destroy */ inline __fastcall virtual ~TLMDRichLabel(void) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomRichScrollText : public TLMDCustomRichLabel
{
	typedef TLMDCustomRichLabel inherited;
	
private:
	TLMDRTFScrollStyle FScrollStyle;
	bool FScroll;
	TLMDRTFScrollDirection FDirection;
	int FTicks;
	Vcl::Extctrls::TTimer* FTimer;
	int FStep;
	int FMaxWidth;
	int FMaxHeight;
	int __fastcall GetDelay(void);
	void __fastcall SetScrollStyle(const TLMDRTFScrollStyle Value);
	void __fastcall SetScroll(const bool Value);
	void __fastcall SetDirection(const TLMDRTFScrollDirection Value);
	void __fastcall SetDelay(int value);
	void __fastcall ScrollByTimer(System::TObject* Sender);
	void __fastcall Complete(void);
	void __fastcall SetMaxHeight(const int Value);
	void __fastcall SetMaxWidth(const int Value);
	
protected:
	virtual int __fastcall ImageWidth(void);
	virtual int __fastcall ImageHeight(void);
	virtual void __fastcall Paint(void);
	
public:
	virtual void __fastcall StepIt(void);
	__fastcall virtual TLMDCustomRichScrollText(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomRichScrollText(void);
	__property TLMDRTFScrollDirection Direction = {read=FDirection, write=SetDirection, default=0};
	__property TLMDRTFScrollStyle ScrollStyle = {read=FScrollStyle, write=SetScrollStyle, default=0};
	__property bool Scroll = {read=FScroll, write=SetScroll, default=0};
	__property int Step = {read=FStep, write=FStep, default=10};
	__property int Delay = {read=GetDelay, write=SetDelay, default=200};
	__property int MaxWidth = {read=FMaxWidth, write=SetMaxWidth, default=3000};
	__property int MaxHeight = {read=FMaxHeight, write=SetMaxHeight, default=3000};
};


class PASCALIMPLEMENTATION TLMDRichScrollText : public TLMDCustomRichScrollText
{
	typedef TLMDCustomRichScrollText inherited;
	
__published:
	__property AlphaBlend = {default=0};
	__property AlphaBlendValue = {default=255};
	__property Direction = {default=0};
	__property ScrollStyle = {default=0};
	__property Scroll = {default=0};
	__property AutoURLDetect = {default=1};
	__property AutoURLPopup = {default=1};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Bevel;
	__property BiDiMode;
	__property Cursor = {default=0};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Hint = {default=0};
	__property Font;
	__property Lines;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property RichStorage;
	__property RichStorageItem = {default=-1};
	__property ShowHint;
	__property Transparent = {default=0};
	__property WordWrap = {default=1};
	__property MaxWidth = {default=3000};
	__property MaxHeight = {default=3000};
	__property Visible = {default=1};
	__property OnURLClick;
	__property OnLinkClick;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
	__property Step = {default=10};
	__property Delay = {default=200};
public:
	/* TLMDCustomRichScrollText.Create */ inline __fastcall virtual TLMDRichScrollText(System::Classes::TComponent* aOwner) : TLMDCustomRichScrollText(aOwner) { }
	/* TLMDCustomRichScrollText.Destroy */ inline __fastcall virtual ~TLMDRichScrollText(void) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomRichScrollBox : public TLMDCustomRichLabel
{
	typedef TLMDCustomRichLabel inherited;
	
private:
	Vcl::Stdctrls::TScrollBar* FHScrollBar;
	Vcl::Stdctrls::TScrollBar* FVScrollBar;
	void __fastcall UpdateBarsPos(void);
	void __fastcall UpdateBars(void);
	void __fastcall ScrollBarChange(System::TObject* Sander);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Winapi::Messages::TMessage &aMessage);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall UpdateImage(void);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* aParent);
	virtual void __fastcall SetOffset(int aDeltaX, int aDeltaY);
	
public:
	__fastcall virtual TLMDCustomRichScrollBox(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomRichScrollBox(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
};


class PASCALIMPLEMENTATION TLMDRichScrollBar : public Vcl::Stdctrls::TScrollBar
{
	typedef Vcl::Stdctrls::TScrollBar inherited;
	
private:
	TLMDCustomRichScrollBox* FScrollBox;
	
public:
	__fastcall TLMDRichScrollBar(System::Classes::TComponent* aOwner, TLMDCustomRichScrollBox* aScrollBox);
	__fastcall virtual ~TLMDRichScrollBar(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRichScrollBar(HWND ParentWindow) : Vcl::Stdctrls::TScrollBar(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDRichScrollBox : public TLMDCustomRichScrollBox
{
	typedef TLMDCustomRichScrollBox inherited;
	
__published:
	__property AutoURLDetect = {default=1};
	__property AutoURLPopup = {default=1};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AlphaBlend = {default=0};
	__property AlphaBlendValue = {default=255};
	__property Bevel;
	__property BiDiMode;
	__property Cursor = {default=0};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Hint = {default=0};
	__property Font;
	__property Lines;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property RichStorage;
	__property RichStorageItem = {default=-1};
	__property ShowHint;
	__property Transparent = {default=0};
	__property WordWrap = {default=1};
	__property Visible = {default=1};
	__property OnURLClick;
	__property OnLinkClick;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TLMDCustomRichScrollBox.Create */ inline __fastcall virtual TLMDRichScrollBox(System::Classes::TComponent* aOwner) : TLMDCustomRichScrollBox(aOwner) { }
	/* TLMDCustomRichScrollBox.Destroy */ inline __fastcall virtual ~TLMDRichScrollBox(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtflabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFLABEL)
using namespace Lmdrtflabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtflabelHPP
