// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolCtrls.pas' rev: 4.00

#ifndef CoolCtrlsHPP
#define CoolCtrlsHPP

#pragma delphiheader begin
#pragma option push -w-
#include <Mask.hpp>	// Pascal unit
#include <jpeg.hpp>	// Pascal unit
#include <CoolUtils.hpp>	// Pascal unit
#include <ActnList.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <ToolWin.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <FileCtrl.hpp>	// Pascal unit
#include <ShellAPI.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
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

namespace Coolctrls
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TCoolOption { ocPaintWallpaper, ocStretchWallpaper, ocPaintSelWallpaper, ocPaintCaptionWallpaper, 
	ocInvertWallpaperAsSelect, ocPaintGradiently, ocBevelOnlyIfSel, ocUseImageList, ocUseGlyphAssign, oc3dMDIForm, 
	ocWallpaperForMDIChildren, ocGradientForMDIChildren, ocNoCaption, ocSmallCaption, ocNoMDIChildrensCaptions, 
	ocDragUsingClientArea, ocNoDragUsingCaption, ocRoundedForm, ocFlatBorder, ocPaintFormSemiTransparently, 
	ocPaintTransparently };
#pragma option pop

typedef Set<TCoolOption, ocPaintWallpaper, ocPaintTransparently>  TCoolOptions;

#pragma option push -b-
enum TCoolControlStyle { ctCoolControl, ctColorControl, ctFontControl, ctPrinterControl, ctCheckControl, 
	ctFolderControl };
#pragma option pop

#pragma option push -b-
enum TScrollDirection { sdBottomToTop, sdTopToBottom, sdLeftToRight, sdRightToLeft };
#pragma option pop

#pragma option push -b-
enum TGradientDirection { gdHorizontal, gdVertical };
#pragma option pop

typedef void __fastcall (__closure *TDrawButtonEvent)(System::TObject* Sender, Graphics::TCanvas* ACanvas
	, const Windows::TRect &R);

class DELPHICLASS TCCAboutBox;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCCAboutBox : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TCCAboutBox(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TCCAboutBox(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolChangeLink;
class DELPHICLASS TCoolImages;
class DELPHICLASS TImages;
class DELPHICLASS TImageItem;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TImages : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
private:
	TCoolImages* FCoolImages;
	HIDESBASE TImageItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TImageItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	__fastcall TImages(TCoolImages* CoolImages);
	HIDESBASE TImageItem* __fastcall Add(void);
	__property TImageItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TImages(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolImages : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TCCAboutBox* FAboutBox;
	Classes::TList* FClients;
	TImages* FImages;
	
protected:
	DYNAMIC void __fastcall Change(void);
	
public:
	__fastcall virtual TCoolImages(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolImages(void);
	void __fastcall RegisterChanges(TCoolChangeLink* Value);
	void __fastcall UnRegisterChanges(TCoolChangeLink* Value);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property TImages* Images = {read=FImages, write=FImages};
};

#pragma pack(pop)

#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolChangeLink : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TCoolImages* FSender;
	Classes::TNotifyEvent FOnChange;
	
public:
	__fastcall virtual ~TCoolChangeLink(void);
	DYNAMIC void __fastcall Change(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TCoolImages* Sender = {read=FSender, write=FSender};
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TCoolChangeLink(void) : System::TObject() { }
	#pragma option pop
	
};

#pragma pack(pop)

#pragma pack(push, 4)
class PASCALIMPLEMENTATION TImageItem : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Graphics::TBitmap* FBitmap;
	Graphics::TPicture* FPicture;
	void __fastcall SetPicture(Graphics::TPicture* Value);
	Graphics::TBitmap* __fastcall GetBitmap(void);
	
protected:
	void __fastcall OnChange(System::TObject* Sender);
	
public:
	__property Graphics::TBitmap* Bitmap = {read=GetBitmap};
	__fastcall virtual TImageItem(Classes::TCollection* Collection);
	__fastcall virtual ~TImageItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TMyNotifyEvent)(int Index, int &GlAssign);

class DELPHICLASS TCoolListBox;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolListBox : public Stdctrls::TCustomListBox 
{
	typedef Stdctrls::TCustomListBox inherited;
	
private:
	Graphics::TColor FSelColor;
	Graphics::TColor FCaptionColor;
	Graphics::TColor FCaptionTextColor;
	Graphics::TFont* FSelFont;
	void *FGlyph;
	Graphics::TBitmap* FWallpaper;
	Graphics::TBitmap* FSelWallpaper;
	Graphics::TBitmap* FCaptionWallpaper;
	TCoolOptions FOptions;
	Controls::TBevelCut FBevelInner;
	Controls::TBevelCut FBevelOuter;
	Coolutils::TBevelStyleEx FBevelStyle;
	Imglist::TChangeLink* FImageChangeLink;
	TCoolChangeLink* FCoolImagesChangeLink;
	Controls::TImageList* FImages;
	Graphics::TColor FColorValue;
	TCoolControlStyle FExtendedStyle;
	bool FTrueType;
	bool FFlatCheckBox;
	bool FExtendedCheck;
	Classes::TCollection* FWrappers;
	Classes::TList* FSaveStates;
	bool FHotTray;
	TCCAboutBox* FAboutBox;
	int FMaxWidth;
	bool FLightColorControl;
	Graphics::TFont* FFontValue;
	AnsiString FFolderName;
	Filectrl::TFileType FFileType;
	AnsiString FFileMask;
	bool FFontAutoUpdate;
	Byte FTransparencyLevel;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	int FidSelWallpaper;
	int FidCaptionWallpaper;
	Graphics::TColor FShadowColor;
	Byte FShadowSize;
	Coolutils::TShadowPosition FShadowPos;
	bool FSimpleView;
	Toolwin::TEdgeBorders FEdgeBorders;
	Graphics::TPen* FBorderPen;
	Graphics::TColor FBordersTrColor;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	TMyNotifyEvent FOnGlyphDraw;
	void __fastcall SetGlyph(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetGlyph(void);
	Buttons::TNumGlyphs __fastcall GetNumGlyphs(void);
	void __fastcall SetNumGlyphs(Buttons::TNumGlyphs Value);
	void __fastcall GlyphChanged(System::TObject* Sender);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall SetSelWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetSelWallpaper(void);
	void __fastcall SetCaptionWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetCaptionWallpaper(void);
	void __fastcall SetOptions(TCoolOptions Value);
	void __fastcall SetImages(Controls::TImageList* Value);
	void __fastcall SetBevelInner(Controls::TBevelCut Value);
	void __fastcall SetBevelOuter(Controls::TBevelCut Value);
	void __fastcall SeTBevelStyleEx(Coolutils::TBevelStyleEx Value);
	void __fastcall SetCaptionColor(Graphics::TColor Value);
	void __fastcall SetCaptionTextColor(Graphics::TColor Value);
	void __fastcall SetColorValue(Graphics::TColor Value);
	void __fastcall SetExtendedStyle(TCoolControlStyle Value);
	void __fastcall SetExtendedCheck(bool Value);
	void __fastcall SetTrueType(bool Value);
	void __fastcall SetFontAutoUpdate(bool Value);
	void __fastcall SetSelFont(Graphics::TFont* Value);
	bool __fastcall GetChecked(int Index);
	void __fastcall SetChecked(int Index, bool Value);
	void __fastcall SetState(int Index, Stdctrls::TCheckBoxState Value);
	Stdctrls::TCheckBoxState __fastcall GetState(int Index);
	bool __fastcall GetLocked(int Index);
	void __fastcall SetLocked(int Index, bool Value);
	void __fastcall SetFlatCheckBox(bool Value);
	void __fastcall SetLightColorControl(bool Value);
	void __fastcall SetFontValue(Graphics::TFont* Value);
	void __fastcall SetFolderName(AnsiString Value);
	void __fastcall SetFileMask(AnsiString Value);
	void __fastcall SetFileType(Filectrl::TFileType Value);
	Graphics::TFont* __fastcall GetFontValue(void);
	void __fastcall FontValueChanged(System::TObject* Sender);
	System::TObject* __fastcall CreateWrapper(int Index);
	System::TObject* __fastcall ExtractWrapper(int Index);
	System::TObject* __fastcall GetWrapper(int Index);
	bool __fastcall HaveWrapper(int Index);
	void __fastcall InvalidateCheck(int Index);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall ImageListChange(System::TObject* Sender);
	void __fastcall SelFontChange(System::TObject* Sender);
	void __fastcall SetTransparencyLevel(Byte Value);
	void __fastcall BorderPenChange(System::TObject* Sender);
	void __fastcall SetEdgeBorders(Toolwin::TEdgeBorders Value);
	void __fastcall SetBorderPen(Graphics::TPen* Value);
	void __fastcall SetBordersTrColor(Graphics::TColor Value);
	void __fastcall SetShadowColor(Graphics::TColor Value);
	void __fastcall SetShadowSize(Byte Value);
	void __fastcall SetShadowPos(Coolutils::TShadowPosition Value);
	void __fastcall SetSimpleView(bool Value);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	void __fastcall SetidSelWallpaper(int Value);
	void __fastcall SetidCaptionWallpaper(int Value);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	bool __fastcall CTLDrawCaptionWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
		
	bool __fastcall CTLDrawWallpaperEx(HDC DC, const Windows::TRect &R, const Windows::TRect &SubRect, 
		bool IsStretch, int Mode);
	bool __fastcall CTLDrawSelWallpaperEx(HDC DC, const Windows::TRect &R, const Windows::TRect &SubRect
		, bool IsStretch, int Mode);
	bool __fastcall IsWallpaperAssigned(void);
	bool __fastcall IsSelWallpaperAssigned(void);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	MESSAGE void __fastcall LBGetTopIndex(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	MESSAGE void __fastcall CNCtlColorListBox(Messages::TWMCtlColor &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	MESSAGE void __fastcall WMNCLButtonDblClk(Messages::TWMNCHitMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall WMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TMessage &Message);
	MESSAGE void __fastcall LBAddString(Messages::TMessage &Message);
	MESSAGE void __fastcall LBInsertString(Messages::TMessage &Message);
	MESSAGE void __fastcall LBDeleteString(Messages::TMessage &Message);
	MESSAGE void __fastcall LBResetContent(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMove(Messages::TWMMove &Message);
	MESSAGE void __fastcall WMSetText(Messages::TMessage &Message);
	void __fastcall CreateColorListBox(void);
	AnsiString __fastcall MakeColorStr(AnsiString Value);
	void __fastcall CreateFontListBox(void);
	void __fastcall CreatePrinterListBox(void);
	void __fastcall CreateFolderListBox(void);
	int __fastcall MaxWidth(void);
	int __fastcall RealWidth(AnsiString ItemStr);
	
protected:
	__property Style ;
	virtual void __fastcall NCCtlChanged(void);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall DrawItem(int Index, const Windows::TRect &Recty, Stdctrls::TOwnerDrawState 
		State);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall SetItemData(int Index, int AData);
	DYNAMIC int __fastcall GetItemData(int Index);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	DYNAMIC void __fastcall ResetContent(void);
	DYNAMIC void __fastcall DeleteString(int Index);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	
public:
	__property bool Checked[int Index] = {read=GetChecked, write=SetChecked};
	__property Graphics::TColor ColorValue = {read=FColorValue, write=SetColorValue, nodefault};
	__property Graphics::TFont* FontValue = {read=GetFontValue, write=SetFontValue};
	__property bool Locked[int Index] = {read=GetLocked, write=SetLocked};
	__property Stdctrls::TCheckBoxState State[int Index] = {read=GetState, write=SetState};
	__fastcall virtual TCoolListBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolListBox(void);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Controls::TBevelCut BevelInner = {read=FBevelInner, write=SetBevelInner, default=0};
	__property Controls::TBevelCut BevelOuter = {read=FBevelOuter, write=SetBevelOuter, default=0};
	__property Coolutils::TBevelStyleEx BevelStyle = {read=FBevelStyle, write=SeTBevelStyleEx, default=0
		};
	__property Graphics::TPen* BorderPen = {read=FBorderPen, write=SetBorderPen};
	__property Graphics::TColor BordersTrColor = {read=FBordersTrColor, write=SetBordersTrColor, default=536870911
		};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, default=-2147483645
		};
	__property Graphics::TColor CaptionTextColor = {read=FCaptionTextColor, write=SetCaptionTextColor, 
		default=-2147483629};
	__property Graphics::TBitmap* CaptionWallpaper = {read=GetCaptionWallpaper, write=SetCaptionWallpaper
		};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property TCoolControlStyle ExtendedStyle = {read=FExtendedStyle, write=SetExtendedStyle, default=0
		};
	__property bool ExtendedCheck = {read=FExtendedCheck, write=SetExtendedCheck, default=0};
	__property Toolwin::TEdgeBorders EdgeBorders = {read=FEdgeBorders, write=SetEdgeBorders, default=0}
		;
	__property bool FlatCheckBox = {read=FFlatCheckBox, write=SetFlatCheckBox, default=0};
	__property bool FontAutoUpdate = {read=FFontAutoUpdate, write=SetFontAutoUpdate, default=0};
	__property AnsiString FolderName = {read=FFolderName, write=SetFolderName};
	__property AnsiString FileMask = {read=FFileMask, write=SetFileMask};
	__property Filectrl::TFileType FileType = {read=FFileType, write=SetFileType, default=48};
	__property Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property bool HotTray = {read=FHotTray, write=FHotTray, default=0};
	__property int idCaptionWallpaper = {read=FidCaptionWallpaper, write=SetidCaptionWallpaper, default=-1
		};
	__property int idSelWallpaper = {read=FidSelWallpaper, write=SetidSelWallpaper, default=-1};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property bool LightColorControl = {read=FLightColorControl, write=SetLightColorControl, default=1
		};
	__property Buttons::TNumGlyphs NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, default=1};
	__property TCoolOptions Options = {read=FOptions, write=SetOptions, default=4160};
	__property Graphics::TBitmap* SelWallpaper = {read=GetSelWallpaper, write=SetSelWallpaper};
	__property Graphics::TColor SelColor = {read=FSelColor, write=FSelColor, default=-2147483635};
	__property Graphics::TFont* SelFont = {read=FSelFont, write=SetSelFont};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=-2147483628
		};
	__property Byte ShadowSize = {read=FShadowSize, write=SetShadowSize, default=1};
	__property Coolutils::TShadowPosition ShadowPos = {read=FShadowPos, write=SetShadowPos, default=0};
		
	__property bool SimpleView = {read=FSimpleView, write=SetSimpleView, default=0};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property bool TrueType = {read=FTrueType, write=SetTrueType, default=0};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property Align ;
	__property Anchors ;
	__property BiDiMode ;
	__property BorderStyle ;
	__property Caption ;
	__property Color ;
	__property Columns ;
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property ExtendedSelect ;
	__property Font ;
	__property ImeMode ;
	__property ImeName ;
	__property IntegralHeight ;
	__property ItemHeight ;
	__property Items ;
	__property MultiSelect ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ShowHint ;
	__property Sorted ;
	__property TabOrder ;
	__property TabStop ;
	__property TabWidth ;
	__property Visible ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDrawItem ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMeasureItem ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property TMyNotifyEvent OnGlyphDraw = {read=FOnGlyphDraw, write=FOnGlyphDraw};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolListBox(HWND ParentWindow) : Stdctrls::TCustomListBox(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolComboBox;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolComboBox : public Stdctrls::TCustomComboBox 
{
	typedef Stdctrls::TCustomComboBox inherited;
	
private:
	Graphics::TFont* FSelFont;
	Graphics::TColor FSelColor;
	void *FGlyph;
	Graphics::TBitmap* FWallpaper;
	Graphics::TBitmap* FSelWallpaper;
	TCoolOptions FOptions;
	Controls::TBevelCut FBevelInner;
	Controls::TBevelCut FBevelOuter;
	Coolutils::TBevelStyleEx FBevelStyle;
	Imglist::TChangeLink* FImageChangeLink;
	TCoolChangeLink* FCoolImagesChangeLink;
	Controls::TImageList* FImages;
	unsigned HListBox;
	Windows::TRect HRect;
	Graphics::TColor FColorValue;
	TCoolControlStyle FExtendedStyle;
	bool FTrueType;
	bool FFlatCheckBox;
	bool FExtendedCheck;
	Classes::TCollection* FWrappers;
	Classes::TList* FSaveStates;
	int FListBoxWidth;
	TCCAboutBox* FAboutBox;
	int FMaxWidth;
	bool FLightColorControl;
	Graphics::TFont* FFontValue;
	bool FFontAutoUpdate;
	AnsiString FFolderName;
	Filectrl::TFileType FFileType;
	AnsiString FFileMask;
	Menus::TPopupAlignment FAlignment;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	TMyNotifyEvent FOnGlyphDraw;
	void *FDefListProc;
	void *FNewListProc;
	Graphics::TColor FShadowColor;
	Byte FShadowSize;
	Coolutils::TShadowPosition FShadowPos;
	bool FSimpleView;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	int FidSelWallpaper;
	Byte FTransparencyLevel;
	Toolwin::TEdgeBorders FEdgeBorders;
	Graphics::TPen* FBorderPen;
	Graphics::TColor FBordersTrColor;
	Forms::TFormBorderStyle FBorderStyle;
	void __fastcall BorderPenChange(System::TObject* Sender);
	void __fastcall SetEdgeBorders(Toolwin::TEdgeBorders Value);
	void __fastcall SetBorderPen(Graphics::TPen* Value);
	void __fastcall SetBordersTrColor(Graphics::TColor Value);
	void __fastcall SetBorderStyle(Forms::TBorderStyle Value);
	void __fastcall SetGlyph(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall SetSelWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetSelWallpaper(void);
	void __fastcall SetOptions(TCoolOptions Value);
	void __fastcall SetImages(Controls::TImageList* Value);
	void __fastcall SetBevelInner(Controls::TBevelCut Value);
	void __fastcall SetBevelOuter(Controls::TBevelCut Value);
	void __fastcall SeTBevelStyleEx(Coolutils::TBevelStyleEx Value);
	void __fastcall SetTopIndex(int Value);
	int __fastcall GetTopIndex(void);
	void __fastcall SetColorValue(Graphics::TColor Value);
	void __fastcall SetExtendedStyle(TCoolControlStyle Value);
	void __fastcall SetExtendedCheck(bool Value);
	void __fastcall SetTrueType(bool Value);
	void __fastcall SetFontAutoUpdate(bool Value);
	void __fastcall SetSelFont(Graphics::TFont* Value);
	bool __fastcall GetChecked(int Index);
	void __fastcall SetChecked(int Index, bool Value);
	void __fastcall SetState(int Index, Stdctrls::TCheckBoxState Value);
	Stdctrls::TCheckBoxState __fastcall GetState(int Index);
	bool __fastcall GetLocked(int Index);
	void __fastcall SetLocked(int Index, bool Value);
	void __fastcall SetFlatCheckBox(bool Value);
	void __fastcall SetListBoxWidth(int Value);
	void __fastcall SetLightColorControl(bool Value);
	void __fastcall SetFontValue(Graphics::TFont* Value);
	Graphics::TFont* __fastcall GetFontValue(void);
	void __fastcall FontValueChanged(System::TObject* Sender);
	void __fastcall SetFolderName(AnsiString Value);
	void __fastcall SetFileType(Filectrl::TFileType Value);
	void __fastcall SetFileMask(AnsiString Value);
	System::TObject* __fastcall CreateWrapper(int Index);
	System::TObject* __fastcall ExtractWrapper(int Index);
	System::TObject* __fastcall GetWrapper(int Index);
	bool __fastcall HaveWrapper(int Index);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall ImageListChange(System::TObject* Sender);
	void __fastcall SelFontChange(System::TObject* Sender);
	void __fastcall SetTransparencyLevel(Byte Value);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	void __fastcall SetidSelWallpaper(int Value);
	bool __fastcall CTLDrawWallpaperEx(HDC DC, const Windows::TRect &R, const Windows::TRect &SubRect, 
		bool IsStretch, int Mode);
	bool __fastcall CTLDrawSelWallpaperEx(HDC DC, const Windows::TRect &R, const Windows::TRect &SubRect
		, bool IsStretch, int Mode);
	bool __fastcall IsWallpaperAssigned(void);
	bool __fastcall IsSelWallpaperAssigned(void);
	void __fastcall SetShadowColor(Graphics::TColor Value);
	void __fastcall SetShadowSize(Byte Value);
	void __fastcall SetShadowPos(Coolutils::TShadowPosition Value);
	void __fastcall SetSimpleView(bool Value);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	void __fastcall GlyphChanged(System::TObject* Sender);
	Buttons::TNumGlyphs __fastcall GetNumGlyphs(void);
	void __fastcall SetNumGlyphs(Buttons::TNumGlyphs Value);
	HIDESBASE MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	MESSAGE void __fastcall CBGetTopIndex(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	MESSAGE void __fastcall CBAddString(Messages::TMessage &Message);
	MESSAGE void __fastcall CBInsertString(Messages::TMessage &Message);
	MESSAGE void __fastcall CBDeleteString(Messages::TMessage &Message);
	MESSAGE void __fastcall CBResetContent(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMove(Messages::TWMMove &Message);
	MESSAGE void __fastcall CMPaintListBoxPart(Messages::TMessage &Message);
	void __fastcall CreateColorComboBox(void);
	AnsiString __fastcall MakeColorStr(AnsiString Value);
	void __fastcall CreateFontComboBox(void);
	void __fastcall CreatePrinterComboBox(void);
	void __fastcall CreateFolderComboBox(void);
	int __fastcall MaxWidth(void);
	int __fastcall RealWidth(AnsiString ItemStr);
	
protected:
	__property Style ;
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall DrawItem(int Index, const Windows::TRect &Recty, Stdctrls::TOwnerDrawState 
		State);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall ComboWndProc(Messages::TMessage &Message, HWND ComboWnd, void * ComboProc);
		
	HIDESBASE virtual void __fastcall ListWndProc(Messages::TMessage &Message);
	virtual void __fastcall Loaded(void);
	DYNAMIC int __fastcall GetItemData(int Index);
	DYNAMIC void __fastcall SetItemData(int Index, int AData);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	
public:
	__property Graphics::TColor ColorValue = {read=FColorValue, write=SetColorValue, nodefault};
	__property bool Checked[int Index] = {read=GetChecked, write=SetChecked};
	__property Graphics::TFont* FontValue = {read=GetFontValue, write=SetFontValue};
	__property bool Locked[int Index] = {read=GetLocked, write=SetLocked};
	__property Stdctrls::TCheckBoxState State[int Index] = {read=GetState, write=SetState};
	__property int TopIndex = {read=GetTopIndex, write=SetTopIndex, nodefault};
	__fastcall virtual TCoolComboBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolComboBox(void);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Menus::TPopupAlignment Alignment = {read=FAlignment, write=FAlignment, default=0};
	__property Controls::TBevelCut BevelInner = {read=FBevelInner, write=SetBevelInner, default=0};
	__property Controls::TBevelCut BevelOuter = {read=FBevelOuter, write=SetBevelOuter, default=0};
	__property Coolutils::TBevelStyleEx BevelStyle = {read=FBevelStyle, write=SeTBevelStyleEx, default=0
		};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property Graphics::TPen* BorderPen = {read=FBorderPen, write=SetBorderPen};
	__property Graphics::TColor BordersTrColor = {read=FBordersTrColor, write=SetBordersTrColor, default=536870911
		};
	__property Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property Toolwin::TEdgeBorders EdgeBorders = {read=FEdgeBorders, write=SetEdgeBorders, default=0}
		;
	__property TCoolControlStyle ExtendedStyle = {read=FExtendedStyle, write=SetExtendedStyle, default=0
		};
	__property bool ExtendedCheck = {read=FExtendedCheck, write=SetExtendedCheck, default=0};
	__property AnsiString FileMask = {read=FFileMask, write=SetFileMask};
	__property Filectrl::TFileType FileType = {read=FFileType, write=SetFileType, default=48};
	__property bool FlatCheckBox = {read=FFlatCheckBox, write=SetFlatCheckBox, default=0};
	__property bool FontAutoUpdate = {read=FFontAutoUpdate, write=SetFontAutoUpdate, default=0};
	__property AnsiString FolderName = {read=FFolderName, write=SetFolderName};
	__property Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property int idSelWallpaper = {read=FidSelWallpaper, write=SetidSelWallpaper, default=-1};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property bool LightColorControl = {read=FLightColorControl, write=SetLightColorControl, default=1
		};
	__property int ListBoxWidth = {read=FListBoxWidth, write=SetListBoxWidth, nodefault};
	__property Buttons::TNumGlyphs NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, default=1};
	__property TCoolOptions Options = {read=FOptions, write=SetOptions, default=64};
	__property Graphics::TBitmap* SelWallpaper = {read=GetSelWallpaper, write=SetSelWallpaper};
	__property Graphics::TColor SelColor = {read=FSelColor, write=FSelColor, default=-2147483635};
	__property Graphics::TFont* SelFont = {read=FSelFont, write=SetSelFont};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=-2147483628
		};
	__property Byte ShadowSize = {read=FShadowSize, write=SetShadowSize, default=1};
	__property Coolutils::TShadowPosition ShadowPos = {read=FShadowPos, write=SetShadowPos, default=0};
		
	__property bool SimpleView = {read=FSimpleView, write=SetSimpleView, default=0};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property bool TrueType = {read=FTrueType, write=SetTrueType, default=0};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property Anchors ;
	__property BiDiMode ;
	__property Color ;
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property DropDownCount ;
	__property Enabled ;
	__property Font ;
	__property ImeMode ;
	__property ImeName ;
	__property ItemHeight ;
	__property Items ;
	__property MaxLength ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ShowHint ;
	__property Sorted ;
	__property TabOrder ;
	__property TabStop ;
	__property Text ;
	__property Visible ;
	__property OnChange ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDrawItem ;
	__property OnDropDown ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMeasureItem ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property TMyNotifyEvent OnGlyphDraw = {read=FOnGlyphDraw, write=FOnGlyphDraw};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolComboBox(HWND ParentWindow) : Stdctrls::TCustomComboBox(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TEndCellEditingEvent)(System::TObject* Sender, int ACol, int ARow
	, int &CellWidth, int &CellHeight);

class DELPHICLASS TCoolStringGrid;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolStringGrid : public Grids::TStringGrid 
{
	typedef Grids::TStringGrid inherited;
	
private:
	TCoolOptions FExOptions;
	Graphics::TColor FSelColor;
	Graphics::TColor FCaptionColor;
	Graphics::TColor FCaptionTextColor;
	Graphics::TBitmap* FWallpaper;
	Graphics::TBitmap* FSelWallpaper;
	Graphics::TBitmap* FCaptionWallpaper;
	Classes::TList* FWrappers;
	Classes::TAlignment FTextAlign;
	Classes::TAlignment FFixedTextAlign;
	Controls::TBevelCut FInnerCellsBevel;
	Controls::TBevelCut FOuterCellsBevel;
	bool FCanEdit;
	TCCAboutBox* FAboutBox;
	int FCellMarginTop;
	int FCellMarginLeft;
	int FCellMarginRight;
	int FCellMarginBottom;
	Classes::TNotifyEvent FOnPaint;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	TEndCellEditingEvent FOnEndCellEditing;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	int FidSelWallpaper;
	int FidCaptionWallpaper;
	TCoolChangeLink* FCoolImagesChangeLink;
	Byte FTransparencyLevel;
	int FGridFormat;
	void __fastcall SetExOptions(TCoolOptions Value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall SetSelWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetSelWallpaper(void);
	void __fastcall SetCaptionWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetCaptionWallpaper(void);
	void __fastcall SetCaptionColor(Graphics::TColor Value);
	void __fastcall SetCaptionTextColor(Graphics::TColor Value);
	Graphics::TColor __fastcall GetColors(int ACol, int ARow);
	void __fastcall SetColors(int ACol, int ARow, Graphics::TColor Value);
	bool __fastcall GetReadOnlyCells(int ACol, int ARow);
	void __fastcall SetReadOnlyCells(int ACol, int ARow, bool Value);
	bool __fastcall GetWallpaperForCells(int ACol, int ARow);
	void __fastcall SetWallpaperForCells(int ACol, int ARow, bool Value);
	Graphics::TFont* __fastcall GetFonts(int ACol, int ARow);
	void __fastcall SetFonts(int ACol, int ARow, Graphics::TFont* Value);
	Classes::TAlignment __fastcall GetCellTextAligns(int ACol, int ARow);
	void __fastcall SetCellTextAligns(int ACol, int ARow, Classes::TAlignment Value);
	void __fastcall SetInnerCellsBevel(Controls::TBevelCut Value);
	void __fastcall SetOuterCellsBevel(Controls::TBevelCut Value);
	void __fastcall SetTextAlign(Classes::TAlignment Value);
	void __fastcall SetFixedTextAlign(Classes::TAlignment Value);
	void __fastcall SetSelColor(Graphics::TColor Value);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall SetTransparencyLevel(Byte Value);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	void __fastcall SetidSelWallpaper(int Value);
	void __fastcall SetidCaptionWallpaper(int Value);
	void __fastcall SetCellMarginTop(int Value);
	void __fastcall SetCellMarginLeft(int Value);
	void __fastcall SetCellMarginRight(int Value);
	void __fastcall SetCellMarginBottom(int Value);
	bool __fastcall CTLDrawCaptionWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
		
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	bool __fastcall CTLDrawWallpaperEx(HDC DC, const Windows::TRect &R, const Windows::TRect &SubRect, 
		bool IsStretch, int Mode);
	bool __fastcall CTLDrawSelWallpaperEx(HDC DC, const Windows::TRect &R, const Windows::TRect &SubRect
		, bool IsStretch, int Mode);
	bool __fastcall IsWallpaperAssigned(void);
	bool __fastcall IsSelWallpaperAssigned(void);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	MESSAGE void __fastcall WMNCLButtonDblClk(Messages::TWMNCHitMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMove(Messages::TWMMove &Message);
	MESSAGE void __fastcall WMSetText(Messages::TMessage &Message);
	MESSAGE void __fastcall CMEndEditing(Messages::TMessage &Message);
	System::TObject* __fastcall CreateWrapper(int ACol, int ARow);
	System::TObject* __fastcall ExtractWrapper(int ACol, int ARow);
	System::TObject* __fastcall GetWrapper(int ACol, int ARow);
	bool __fastcall HaveWrapper(int ACol, int ARow);
	
protected:
	AnsiString EditValue;
	virtual void __fastcall NCCtlChanged(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall DrawCell(int ACol, int ARow, const Windows::TRect &ARect, Grids::TGridDrawState 
		AState);
	DYNAMIC void __fastcall ColumnMoved(int FromIndex, int ToIndex);
	DYNAMIC void __fastcall RowMoved(int FromIndex, int ToIndex);
	DYNAMIC void __fastcall AdjustSize(int Index, int Amount, bool Rows);
	DYNAMIC void __fastcall SetEditText(int ACol, int ARow, const AnsiString Value);
	DYNAMIC AnsiString __fastcall GetEditText(int ACol, int ARow);
	virtual Grids::TInplaceEdit* __fastcall CreateEditor(void);
	virtual bool __fastcall SelectCell(int ACol, int ARow);
	virtual bool __fastcall CanEditShow(void);
	DYNAMIC void __fastcall TopLeftChanged(void);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__property Classes::TAlignment CellTextAligns[int ACol][int ARow] = {read=GetCellTextAligns, write=
		SetCellTextAligns};
	__property Graphics::TColor Colors[int ACol][int ARow] = {read=GetColors, write=SetColors};
	__property Graphics::TFont* Fonts[int ACol][int ARow] = {read=GetFonts, write=SetFonts};
	__property bool ReadOnlyCells[int ACol][int ARow] = {read=GetReadOnlyCells, write=SetReadOnlyCells}
		;
	__property bool WallpaperForCells[int ACol][int ARow] = {read=GetWallpaperForCells, write=SetWallpaperForCells
		};
	__fastcall virtual TCoolStringGrid(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolStringGrid(void);
	void __fastcall DeleteRows(int RowIndex, int Amount);
	void __fastcall InsertRows(int RowIndex, int Amount);
	void __fastcall DeleteCols(int ColIndex, int Amount);
	void __fastcall InsertCols(int ColIndex, int Amount);
	bool __fastcall PosCell(AnsiString SubStr, int &ACol, int &ARow);
	void __fastcall Clear(void);
	void __fastcall SaveToStream(Classes::TStream* AStream);
	void __fastcall LoadFromStream(Classes::TStream* AStream);
	void __fastcall SaveToFile(AnsiString AFileName);
	void __fastcall LoadFromFile(AnsiString AFileName);
	void __fastcall SaveToHTMLFile(AnsiString AFileName);
	void __fastcall CopyToClipboard(void);
	void __fastcall PasteFromClipboard(void);
	void __fastcall CopyToClipboardCell(int ACol, int ARow);
	void __fastcall CutToClipboardCell(int ACol, int ARow);
	void __fastcall PasteFromClipboardCell(int ACol, int ARow);
	void __fastcall SetColumnParameters(int ACol, bool AFixedInclude, Graphics::TColor AColor, bool AReadOnly
		, bool AWallpaperAlloved, Graphics::TFont* AFont, Classes::TAlignment ATextAlign);
	void __fastcall SetRowParameters(int ARow, bool AFixedInclude, Graphics::TColor AColor, bool AReadOnly
		, bool AWallpaperAlloved, Graphics::TFont* AFont, Classes::TAlignment ATextAlign);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, default=-2147483645
		};
	__property Graphics::TColor CaptionTextColor = {read=FCaptionTextColor, write=SetCaptionTextColor, 
		default=-2147483629};
	__property Graphics::TBitmap* CaptionWallpaper = {read=GetCaptionWallpaper, write=SetCaptionWallpaper
		};
	__property int CellMarginTop = {read=FCellMarginTop, write=SetCellMarginTop, default=2};
	__property int CellMarginLeft = {read=FCellMarginLeft, write=SetCellMarginLeft, default=2};
	__property int CellMarginRight = {read=FCellMarginRight, write=SetCellMarginRight, default=-2};
	__property int CellMarginBottom = {read=FCellMarginBottom, write=SetCellMarginBottom, default=-2};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property TCoolOptions ExOptions = {read=FExOptions, write=SetExOptions, default=4096};
	__property Classes::TAlignment FixedTextAlign = {read=FFixedTextAlign, write=SetFixedTextAlign, default=0
		};
	__property Controls::TBevelCut InnerCellsBevel = {read=FInnerCellsBevel, write=SetInnerCellsBevel, 
		default=0};
	__property int idCaptionWallpaper = {read=FidCaptionWallpaper, write=SetidCaptionWallpaper, default=-1
		};
	__property int idSelWallpaper = {read=FidSelWallpaper, write=SetidSelWallpaper, default=-1};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property Controls::TBevelCut OuterCellsBevel = {read=FOuterCellsBevel, write=SetOuterCellsBevel, 
		default=0};
	__property Graphics::TColor SelColor = {read=FSelColor, write=SetSelColor, default=-2147483635};
	__property Graphics::TBitmap* SelWallpaper = {read=GetSelWallpaper, write=SetSelWallpaper};
	__property Classes::TAlignment TextAlign = {read=FTextAlign, write=SetTextAlign, default=0};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property TEndCellEditingEvent OnEndCellEditing = {read=FOnEndCellEditing, write=FOnEndCellEditing
		};
	__property Classes::TNotifyEvent OnPaint = {read=FOnPaint, write=FOnPaint};
	__property Caption ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolStringGrid(HWND ParentWindow) : Grids::TStringGrid(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolInplaceEdit;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolInplaceEdit : public Grids::TInplaceEdit 
{
	typedef Grids::TInplaceEdit inherited;
	
private:
	TCCAboutBox* FAboutBox;
	bool FBeingPainted;
	TCoolOptions FOptions;
	bool FReturnWanted;
	Classes::TAlignment FTextAlign;
	Graphics::TBitmap* FWallpaper;
	Byte FTransparencyLevel;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	TCoolChangeLink* FCoolImagesChangeLink;
	Toolwin::TEdgeBorders FEdgeBorders;
	Graphics::TPen* FBorderPen;
	Graphics::TColor FBordersTrColor;
	void __fastcall BorderPenChange(System::TObject* Sender);
	void __fastcall SetOptions(TCoolOptions Value);
	void __fastcall SetTextAlign(Classes::TAlignment Value);
	void __fastcall SetTransparencyLevel(Byte Value);
	void __fastcall SetEdgeBorders(Toolwin::TEdgeBorders Value);
	void __fastcall SetBorderPen(Graphics::TPen* Value);
	void __fastcall SetBordersTrColor(Graphics::TColor Value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	bool __fastcall IsWallpaperAssigned(void);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	MESSAGE void __fastcall CNCtlColorEdit(Messages::TWMCtlColor &Message);
	MESSAGE void __fastcall CNCtlColorStatic(Messages::TWMCtlColor &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMMove(Messages::TWMMove &Message);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall DoPaint(void);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	__property PasswordChar ;
	
public:
	__fastcall virtual TCoolInplaceEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolInplaceEdit(void);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Graphics::TPen* BorderPen = {read=FBorderPen, write=SetBorderPen};
	__property Graphics::TColor BordersTrColor = {read=FBordersTrColor, write=SetBordersTrColor, default=536870911
		};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property Toolwin::TEdgeBorders EdgeBorders = {read=FEdgeBorders, write=SetEdgeBorders, default=0}
		;
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property TCoolOptions Options = {read=FOptions, write=SetOptions, default=0};
	__property Classes::TAlignment TextAlign = {read=FTextAlign, write=SetTextAlign, default=0};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property Color ;
	__property Font ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolInplaceEdit(HWND ParentWindow) : Grids::TInplaceEdit(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolEdit;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolEdit : public Stdctrls::TCustomEdit 
{
	typedef Stdctrls::TCustomEdit inherited;
	
private:
	TCCAboutBox* FAboutBox;
	bool FBeingPainted;
	TCoolOptions FOptions;
	bool FReturnWanted;
	Classes::TAlignment FTextAlign;
	Graphics::TBitmap* FWallpaper;
	Byte FTransparencyLevel;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	TCoolChangeLink* FCoolImagesChangeLink;
	Toolwin::TEdgeBorders FEdgeBorders;
	Graphics::TPen* FBorderPen;
	Graphics::TColor FBordersTrColor;
	void __fastcall BorderPenChange(System::TObject* Sender);
	void __fastcall SetOptions(TCoolOptions Value);
	void __fastcall SetTextAlign(Classes::TAlignment Value);
	void __fastcall SetTransparencyLevel(Byte Value);
	void __fastcall SetEdgeBorders(Toolwin::TEdgeBorders Value);
	void __fastcall SetBorderPen(Graphics::TPen* Value);
	void __fastcall SetBordersTrColor(Graphics::TColor Value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	bool __fastcall IsWallpaperAssigned(void);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	MESSAGE void __fastcall CNCtlColorEdit(Messages::TWMCtlColor &Message);
	MESSAGE void __fastcall CNCtlColorStatic(Messages::TWMCtlColor &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMMove(Messages::TWMMove &Message);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall DoPaint(void);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	__property PasswordChar ;
	
public:
	__fastcall virtual TCoolEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolEdit(void);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Graphics::TPen* BorderPen = {read=FBorderPen, write=SetBorderPen};
	__property Graphics::TColor BordersTrColor = {read=FBordersTrColor, write=SetBordersTrColor, default=536870911
		};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property Toolwin::TEdgeBorders EdgeBorders = {read=FEdgeBorders, write=SetEdgeBorders, default=0}
		;
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property TCoolOptions Options = {read=FOptions, write=SetOptions, default=0};
	__property Classes::TAlignment TextAlign = {read=FTextAlign, write=SetTextAlign, default=0};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property Anchors ;
	__property AutoSelect ;
	__property AutoSize ;
	__property BiDiMode ;
	__property BorderStyle ;
	__property CharCase ;
	__property Color ;
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property Font ;
	__property HideSelection ;
	__property ImeMode ;
	__property ImeName ;
	__property MaxLength ;
	__property OEMConvert ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ReadOnly ;
	__property ShowHint ;
	__property TabOrder ;
	__property TabStop ;
	__property Text ;
	__property Visible ;
	__property OnChange ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolEdit(HWND ParentWindow) : Stdctrls::TCustomEdit(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolEditBtn;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolEditBtn : public TCoolEdit 
{
	typedef TCoolEdit inherited;
	
private:
	Buttons::TSpeedButton* FButton;
	Classes::TNotifyEvent FOnBtnClick;
	int __fastcall GetMinHeight(void);
	void __fastcall SetEditRect(void);
	Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetGlyph(Graphics::TBitmap* Value);
	void __fastcall SetBtnCaption(AnsiString Value);
	AnsiString __fastcall GetBtnCaption();
	Buttons::TNumGlyphs __fastcall GetNumGlyphs(void);
	void __fastcall SetNumGlyphs(Buttons::TNumGlyphs Value);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	void __fastcall BtnClick(System::TObject* Sender);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	
public:
	__fastcall virtual TCoolEditBtn(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolEditBtn(void);
	__property Buttons::TSpeedButton* Button = {read=FButton};
	
__published:
	__property Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property AnsiString BtnCaption = {read=GetBtnCaption, write=SetBtnCaption};
	__property Buttons::TNumGlyphs NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, default=1};
	__property Classes::TNotifyEvent OnBtnClick = {read=FOnBtnClick, write=FOnBtnClick};
	__property Action ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolEditBtn(HWND ParentWindow) : TCoolEdit(ParentWindow
		) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolMemo;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolMemo : public Stdctrls::TCustomMemo 
{
	typedef Stdctrls::TCustomMemo inherited;
	
private:
	AnsiString FCaption;
	Graphics::TColor FCaptionColor;
	Graphics::TColor FCaptionTextColor;
	Graphics::TBitmap* FCaptionWallpaper;
	TCoolOptions FOptions;
	Classes::TAlignment FTextAlign;
	Graphics::TBitmap* FWallpaper;
	TCCAboutBox* FAboutBox;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	int FOldSelStart;
	bool FBeingPainted;
	Byte FTransparencyLevel;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	int FidCaptionWallpaper;
	TCoolChangeLink* FCoolImagesChangeLink;
	Toolwin::TEdgeBorders FEdgeBorders;
	Graphics::TPen* FBorderPen;
	Graphics::TColor FBordersTrColor;
	void __fastcall BorderPenChange(System::TObject* Sender);
	void __fastcall SetOptions(TCoolOptions Value);
	void __fastcall SetTextAlign(Classes::TAlignment Value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall SetCaptionWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetCaptionWallpaper(void);
	void __fastcall SetCaptionColor(Graphics::TColor Value);
	void __fastcall SetCaptionTextColor(Graphics::TColor Value);
	void __fastcall SetTransparencyLevel(Byte Value);
	void __fastcall SetCaption(AnsiString Value);
	AnsiString __fastcall GetCaption();
	void __fastcall SetEdgeBorders(Toolwin::TEdgeBorders Value);
	void __fastcall SetBorderPen(Graphics::TPen* Value);
	void __fastcall SetBordersTrColor(Graphics::TColor Value);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	void __fastcall SetidCaptionWallpaper(int Value);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	bool __fastcall CTLDrawCaptionWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
		
	bool __fastcall IsWallpaperAssigned(void);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	MESSAGE void __fastcall CNCtlColorEdit(Messages::TWMCtlColor &Message);
	MESSAGE void __fastcall CNCtlColorStatic(Messages::TWMCtlColor &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMMove(Messages::TWMMove &Message);
	HIDESBASE MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	MESSAGE void __fastcall WMSetText(Messages::TMessage &Message);
	MESSAGE void __fastcall WMNCLButtonDblClk(Messages::TWMNCHitMessage &Message);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int 
		Y);
	DYNAMIC void __fastcall DoPaint(void);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall NCCtlChanged(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TCoolMemo(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolMemo(void);
	virtual void __fastcall SetFocus(void);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Graphics::TPen* BorderPen = {read=FBorderPen, write=SetBorderPen};
	__property Graphics::TColor BordersTrColor = {read=FBordersTrColor, write=SetBordersTrColor, default=536870911
		};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, default=-2147483645
		};
	__property Graphics::TColor CaptionTextColor = {read=FCaptionTextColor, write=SetCaptionTextColor, 
		default=-2147483629};
	__property Graphics::TBitmap* CaptionWallpaper = {read=GetCaptionWallpaper, write=SetCaptionWallpaper
		};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property Toolwin::TEdgeBorders EdgeBorders = {read=FEdgeBorders, write=SetEdgeBorders, default=0}
		;
	__property int idCaptionWallpaper = {read=FidCaptionWallpaper, write=SetidCaptionWallpaper, default=-1
		};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property TCoolOptions Options = {read=FOptions, write=SetOptions, default=4096};
	__property Classes::TAlignment TextAlign = {read=FTextAlign, write=SetTextAlign, default=0};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property Align ;
	__property Alignment ;
	__property Anchors ;
	__property BiDiMode ;
	__property BorderStyle ;
	__property Caption  = {read=GetCaption, write=SetCaption};
	__property Color ;
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property Font ;
	__property HideSelection ;
	__property ImeMode ;
	__property ImeName ;
	__property Lines ;
	__property MaxLength ;
	__property OEMConvert ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ReadOnly ;
	__property ScrollBars ;
	__property ShowHint ;
	__property TabOrder ;
	__property TabStop ;
	__property Visible ;
	__property WantReturns ;
	__property WantTabs ;
	__property WordWrap ;
	__property OnChange ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolMemo(HWND ParentWindow) : Stdctrls::TCustomMemo(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolLabel;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolLabel : public Stdctrls::TCustomLabel 
{
	typedef Stdctrls::TCustomLabel inherited;
	
private:
	Graphics::TColor FShadowColor;
	Byte FShadowSize;
	Coolutils::TShadowPosition FShadowPos;
	bool FSimpleView;
	bool FStretched;
	Graphics::TBitmap* FWallpaper;
	Controls::TBevelCut FBevelInner;
	Controls::TBevelCut FBevelOuter;
	int FBevelsOffset;
	void *FGlyph;
	TCCAboutBox* FAboutBox;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	TCoolChangeLink* FCoolImagesChangeLink;
	Toolwin::TEdgeBorders FEdgeBorders;
	Graphics::TPen* FBorderPen;
	void __fastcall BorderPenChange(System::TObject* Sender);
	void __fastcall SetEdgeBorders(Toolwin::TEdgeBorders Value);
	void __fastcall SetBorderPen(Graphics::TPen* Value);
	void __fastcall SetStretched(bool Value);
	void __fastcall SetShadowColor(Graphics::TColor Value);
	void __fastcall SetShadowSize(Byte Value);
	void __fastcall SetShadowPos(Coolutils::TShadowPosition Value);
	void __fastcall SetSimpleView(bool Value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall SetBevelInner(Controls::TBevelCut Value);
	void __fastcall SetBevelOuter(Controls::TBevelCut Value);
	void __fastcall SetBevelsOffset(int Value);
	void __fastcall GlyphChanged(System::TObject* Sender);
	Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetGlyph(Graphics::TBitmap* Value);
	Buttons::TNumGlyphs __fastcall GetNumGlyphs(void);
	void __fastcall SetNumGlyphs(Buttons::TNumGlyphs Value);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	
protected:
	DYNAMIC void __fastcall AdjustBounds(void);
	DYNAMIC void __fastcall DoDrawText(Windows::TRect &Recty, int Flags);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetAutoSize(bool Value);
	
public:
	__fastcall virtual TCoolLabel(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolLabel(void);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Graphics::TPen* BorderPen = {read=FBorderPen, write=SetBorderPen};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property Toolwin::TEdgeBorders EdgeBorders = {read=FEdgeBorders, write=SetEdgeBorders, default=0}
		;
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property Buttons::TNumGlyphs NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, default=1};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=-2147483628
		};
	__property Byte ShadowSize = {read=FShadowSize, write=SetShadowSize, default=1};
	__property Coolutils::TShadowPosition ShadowPos = {read=FShadowPos, write=SetShadowPos, default=0};
		
	__property bool SimpleView = {read=FSimpleView, write=SetSimpleView, default=0};
	__property bool Stretched = {read=FStretched, write=SetStretched, default=0};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property Controls::TBevelCut BevelInner = {read=FBevelInner, write=SetBevelInner, default=0};
	__property Controls::TBevelCut BevelOuter = {read=FBevelOuter, write=SetBevelOuter, default=0};
	__property int BevelsOffset = {read=FBevelsOffset, write=SetBevelsOffset, default=0};
	__property Align ;
	__property Alignment ;
	__property Anchors ;
	__property BiDiMode ;
	__property Constraints ;
	__property DragKind ;
	__property ParentBiDiMode ;
	__property AutoSize ;
	__property Caption ;
	__property Color ;
	__property DragCursor ;
	__property DragMode ;
	__property Enabled ;
	__property FocusControl ;
	__property Font ;
	__property ParentColor ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ShowAccelChar ;
	__property ShowHint ;
	__property Transparent ;
	__property Layout ;
	__property Visible ;
	__property WordWrap ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnStartDock ;
	__property OnEndDrag ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDrag ;
};

#pragma pack(pop)

#pragma option push -b-
enum TCheckRadioType { crCheckBox, crRadioBox };
#pragma option pop

#pragma option push -b-
enum TImageSource { isGlyph, isImageList };
#pragma option pop

class DELPHICLASS TCoolCheckRadioBoxActionLink;
class DELPHICLASS TCoolCheckRadioBox;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolCheckRadioBox : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FTransparent;
	Graphics::TBitmap* FWallpaper;
	Classes::TAlignment FAlignment;
	bool FChecked;
	bool FAllowGrayed;
	bool FDown;
	TCheckRadioType FCheckRadioType;
	int FGroupIndex;
	bool FFlat;
	bool FOwnerDraw;
	bool FStretched;
	Graphics::TColor FShadowColor;
	Byte FShadowSize;
	Coolutils::TShadowPosition FShadowPos;
	bool FSimpleView;
	Controls::TBevelCut FBevelInner;
	Controls::TBevelCut FBevelOuter;
	int FBevelsOffset;
	Byte FTransparencyLevel;
	TCCAboutBox* FAboutBox;
	void *FGlyphMarked;
	void *FGlyphNormal;
	Controls::TImageList* FImages;
	Imglist::TChangeLink* FImageChangeLink;
	TImageSource FImageSrc;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	TCoolChangeLink* FCoolImagesChangeLink;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	void __fastcall SetTransparent(bool Value);
	void __fastcall SetState(Stdctrls::TCheckBoxState Value);
	void __fastcall SetAlignment(Classes::TLeftRight Value);
	void __fastcall SetChecked(bool Value);
	void __fastcall SetCheckRadioType(TCheckRadioType Value);
	void __fastcall SetFlat(bool Value);
	void __fastcall SetShadowColor(Graphics::TColor Value);
	void __fastcall SetShadowSize(Byte Value);
	void __fastcall SetShadowPos(Coolutils::TShadowPosition Value);
	void __fastcall SetSimpleView(bool Value);
	void __fastcall SetBevelInner(Controls::TBevelCut Value);
	void __fastcall SetBevelOuter(Controls::TBevelCut Value);
	void __fastcall SetBevelsOffset(int Value);
	void __fastcall SetOwnerDraw(bool Value);
	void __fastcall SetTransparencyLevel(Byte Value);
	void __fastcall SetStretched(bool Value);
	void __fastcall GlyphMarkedChanged(System::TObject* Sender);
	void __fastcall GlyphNormalChanged(System::TObject* Sender);
	Graphics::TBitmap* __fastcall GetGlyphMarked(void);
	void __fastcall SetGlyphMarked(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetGlyphNormal(void);
	void __fastcall SetGlyphNormal(Graphics::TBitmap* Value);
	Buttons::TNumGlyphs __fastcall GetNumGlyphsMarked(void);
	void __fastcall SetNumGlyphsMarked(Buttons::TNumGlyphs Value);
	Buttons::TNumGlyphs __fastcall GetNumGlyphsNormal(void);
	void __fastcall SetNumGlyphsNormal(Buttons::TNumGlyphs Value);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall ImageListChange(System::TObject* Sender);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	bool __fastcall IsCheckedStored(void);
	void __fastcall SetImages(Controls::TImageList* Value);
	void __fastcall SetImageSrc(TImageSource Value);
	MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChange(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMMove(Messages::TWMMove &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	
protected:
	Stdctrls::TCheckBoxState FState;
	virtual bool __fastcall Toggle(void);
	int __fastcall GetImageHeight(void);
	__property int ImageHeight = {read=GetImageHeight, nodefault};
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall AdjustSize(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int 
		Y);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall InvalidateEx(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	DYNAMIC TMetaClass* __fastcall GetActionLinkClass(void);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	virtual void __fastcall AssignTo(Classes::TPersistent* Dest);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	
public:
	__fastcall virtual TCoolCheckRadioBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolCheckRadioBox(void);
	virtual void __fastcall SetFocus(void);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Classes::TLeftRight Alignment = {read=FAlignment, write=SetAlignment, default=1};
	__property bool AllowGrayed = {read=FAllowGrayed, write=FAllowGrayed, default=0};
	__property Controls::TBevelCut BevelInner = {read=FBevelInner, write=SetBevelInner, default=0};
	__property Controls::TBevelCut BevelOuter = {read=FBevelOuter, write=SetBevelOuter, default=0};
	__property int BevelsOffset = {read=FBevelsOffset, write=SetBevelsOffset, default=0};
	__property bool Checked = {read=FChecked, write=SetChecked, stored=IsCheckedStored, default=0};
	__property TCheckRadioType CheckRadioType = {read=FCheckRadioType, write=SetCheckRadioType, default=0
		};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property int GroupIndex = {read=FGroupIndex, write=FGroupIndex, default=0};
	__property Graphics::TBitmap* GlyphMarked = {read=GetGlyphMarked, write=SetGlyphMarked};
	__property Graphics::TBitmap* GlyphNormal = {read=GetGlyphNormal, write=SetGlyphNormal};
	__property Buttons::TNumGlyphs NumGlyphsMarked = {read=GetNumGlyphsMarked, write=SetNumGlyphsMarked
		, default=1};
	__property Buttons::TNumGlyphs NumGlyphsNormal = {read=GetNumGlyphsNormal, write=SetNumGlyphsNormal
		, default=1};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property TImageSource ImageSource = {read=FImageSrc, write=SetImageSrc, default=0};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property bool OwnerDraw = {read=FOwnerDraw, write=SetOwnerDraw, default=0};
	__property Stdctrls::TCheckBoxState State = {read=FState, write=SetState, default=0};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=-2147483628
		};
	__property Byte ShadowSize = {read=FShadowSize, write=SetShadowSize, default=1};
	__property Coolutils::TShadowPosition ShadowPos = {read=FShadowPos, write=SetShadowPos, default=0};
		
	__property bool SimpleView = {read=FSimpleView, write=SetSimpleView, default=0};
	__property bool Stretched = {read=FStretched, write=SetStretched, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property Action ;
	__property Anchors ;
	__property BiDiMode ;
	__property Caption ;
	__property Color ;
	__property Constraints ;
	__property Ctl3D ;
	__property UseDockManager ;
	__property DockSite ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property Font ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property ShowHint ;
	__property TabOrder ;
	__property TabStop ;
	__property Visible ;
	__property OnCanResize ;
	__property OnClick ;
	__property OnConstrainedResize ;
	__property OnDockDrop ;
	__property OnDockOver ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetSiteInfo ;
	__property OnKeyDown ;
	__property OnKeyUp ;
	__property OnKeyPress ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnUnDock ;
	__property OnStartDrag ;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolCheckRadioBox(HWND ParentWindow) : Controls::TCustomControl(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolCheckRadioBoxActionLink : public Controls::TControlActionLink 
{
	typedef Controls::TControlActionLink inherited;
	
protected:
	TCoolCheckRadioBox* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual void __fastcall SetChecked(bool Value);
public:
	#pragma option push -w-inl
	/* TBasicActionLink.Create */ inline __fastcall virtual TCoolCheckRadioBoxActionLink(System::TObject* 
		AClient) : Controls::TControlActionLink(AClient) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TCoolCheckRadioBoxActionLink(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

typedef TMetaClass*TCoolCheckRadioBoxActionLinkClass;

class DELPHICLASS TCoolGroupBox;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolGroupBox : public Stdctrls::TCustomGroupBox 
{
	typedef Stdctrls::TCustomGroupBox inherited;
	
private:
	bool FTransparent;
	Graphics::TBitmap* FWallpaper;
	Graphics::TColor FShadowColor;
	Byte FShadowSize;
	Coolutils::TShadowPosition FShadowPos;
	bool FSimpleView;
	Byte FTransparencyLevel;
	TCCAboutBox* FAboutBox;
	bool FStretched;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	TCoolChangeLink* FCoolImagesChangeLink;
	void __fastcall SetTransparent(bool Value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall SetShadowColor(Graphics::TColor Value);
	void __fastcall SetShadowSize(Byte Value);
	void __fastcall SetShadowPos(Coolutils::TShadowPosition Value);
	void __fastcall SetSimpleView(bool Value);
	void __fastcall SetTransparencyLevel(Byte Value);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall SetStretched(bool Value);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMove(Messages::TWMMove &Message);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TCoolGroupBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolGroupBox(void);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=-2147483628
		};
	__property Byte ShadowSize = {read=FShadowSize, write=SetShadowSize, default=1};
	__property Coolutils::TShadowPosition ShadowPos = {read=FShadowPos, write=SetShadowPos, default=0};
		
	__property bool SimpleView = {read=FSimpleView, write=SetSimpleView, default=0};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property bool Stretched = {read=FStretched, write=SetStretched, default=0};
	__property Align ;
	__property Anchors ;
	__property BiDiMode ;
	__property Caption ;
	__property Color ;
	__property Constraints ;
	__property Ctl3D ;
	__property DockSite ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property Font ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder ;
	__property TabStop ;
	__property Visible ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDockDrop ;
	__property OnDockOver ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetSiteInfo ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDrag ;
	__property OnStartDock ;
	__property OnUnDock ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolGroupBox(HWND ParentWindow) : Stdctrls::TCustomGroupBox(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TTextScrolledEvent)(System::TObject* Sender, bool &InitialPosition
	);

class DELPHICLASS TThreadTimer;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TThreadTimer : public Classes::TThread 
{
	typedef Classes::TThread inherited;
	
private:
	bool FEnabled;
	Word FInterval;
	Classes::TNotifyEvent FOnTimer;
	void __fastcall SetEnabled(bool Value);
	
protected:
	virtual void __fastcall DoTimer(void);
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TThreadTimer(void);
	__property bool Enabled = {read=FEnabled, write=SetEnabled, nodefault};
	__property Word Interval = {read=FInterval, write=FInterval, nodefault};
	__property Classes::TNotifyEvent OnTimer = {read=FOnTimer, write=FOnTimer};
public:
	#pragma option push -w-inl
	/* TThread.Destroy */ inline __fastcall virtual ~TThreadTimer(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolScrollingText;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolScrollingText : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Classes::TStrings* FStrings;
	bool FActive;
	unsigned FInterval;
	Classes::TAlignment FAlignment;
	TScrollDirection FScrollDirection;
	void *FGlyph;
	Graphics::TColor FShadowColor;
	Byte FShadowSize;
	Coolutils::TShadowPosition FShadowPos;
	bool FSimpleView;
	Controls::TWinControl* FFocusControl;
	bool FShowAccelChar;
	TCCAboutBox* FAboutBox;
	bool FStretched;
	Graphics::TBitmap* FWallpaper;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	TCoolChangeLink* FCoolImagesChangeLink;
	bool FTransparent;
	TThreadTimer* FTimer;
	Graphics::TBitmap* FBackBitmap;
	TTextScrolledEvent FOnTextScrolled;
	void __fastcall CoolImagesChange(System::TObject* Sender);
	bool __fastcall IsWallpaperAssigned(void);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	void __fastcall SetidWallpaper(int Value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall SetStrings(Classes::TStrings* Value);
	void __fastcall StringsChange(System::TObject* Sender);
	void __fastcall SetStretched(bool Value);
	void __fastcall SetActive(bool Value);
	void __fastcall SetInterval(unsigned Value);
	void __fastcall SetAlignment(Classes::TAlignment Value);
	void __fastcall SetScrollDirection(TScrollDirection Value);
	void __fastcall SetShadowColor(Graphics::TColor Value);
	void __fastcall SetShadowSize(Byte Value);
	void __fastcall SetShadowPos(Coolutils::TShadowPosition Value);
	void __fastcall SetSimpleView(bool Value);
	void __fastcall SetFocusControl(Controls::TWinControl* Value);
	void __fastcall SetShowAccelChar(bool Value);
	void __fastcall SetTransparent(bool Value);
	void __fastcall GlyphChanged(System::TObject* Sender);
	Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetGlyph(Graphics::TBitmap* Value);
	Buttons::TNumGlyphs __fastcall GetNumGlyphs(void);
	void __fastcall SetNumGlyphs(Buttons::TNumGlyphs Value);
	virtual void __fastcall DoPaintBackground(void);
	void __fastcall DoPaint(Graphics::TCanvas* Canv);
	void __fastcall DoPaintEvent(void);
	void __fastcall DoTimer(System::TObject* Sender);
	void __fastcall UpdateTimer(void);
	Windows::TRect __fastcall BusyRect();
	MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	
protected:
	int X;
	int Y;
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetName(const AnsiString Value);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	DYNAMIC void __fastcall AdjustBounds(void);
	DYNAMIC void __fastcall AdjustSize(void);
	virtual void __fastcall DoDrawText(Graphics::TCanvas* Canv, Windows::TRect &Recty, int Flags);
	virtual Classes::TStrings* __fastcall GetStrings(void);
	
public:
	__fastcall virtual TCoolScrollingText(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolScrollingText(void);
	void __fastcall SetTextCoordinates(bool Initial);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property Controls::TWinControl* FocusControl = {read=FFocusControl, write=SetFocusControl};
	__property unsigned Interval = {read=FInterval, write=SetInterval, default=25};
	__property Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property Buttons::TNumGlyphs NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, default=1};
	__property TScrollDirection ScrollDirection = {read=FScrollDirection, write=SetScrollDirection, default=3
		};
	__property Classes::TStrings* Strings = {read=GetStrings, write=SetStrings};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=-2147483628
		};
	__property Byte ShadowSize = {read=FShadowSize, write=SetShadowSize, default=1};
	__property Coolutils::TShadowPosition ShadowPos = {read=FShadowPos, write=SetShadowPos, default=0};
		
	__property bool SimpleView = {read=FSimpleView, write=SetSimpleView, default=0};
	__property bool ShowAccelChar = {read=FShowAccelChar, write=SetShowAccelChar, default=1};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property TTextScrolledEvent OnTextScrolled = {read=FOnTextScrolled, write=FOnTextScrolled};
	__property bool Stretched = {read=FStretched, write=SetStretched, default=0};
	__property Align ;
	__property AutoSize ;
	__property Anchors ;
	__property BiDiMode ;
	__property Color ;
	__property Constraints ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property Font ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property ShowHint ;
	__property Visible ;
	__property OnClick ;
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

#pragma pack(pop)

class DELPHICLASS TCoolForm;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolForm : public Forms::TCustomForm 
{
	typedef Forms::TCustomForm inherited;
	
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TCoolForm(Classes::TComponent* AOwner) : Forms::TCustomForm(
		AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCoolForm(Classes::TComponent* AOwner, int Dummy
		) : Forms::TCustomForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCoolForm(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolForm(HWND ParentWindow) : Forms::TCustomForm(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

typedef Byte TTransparencyIntense;

class DELPHICLASS TCoolFormHook;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolFormHook : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Graphics::TBitmap* FWallpaper;
	TCoolOptions FOptions;
	int FRoundXOffset;
	int FRoundYOffset;
	Graphics::TColor FStartColor;
	Graphics::TColor FEndColor;
	Coolutils::TWndHook* FWindowHook;
	TCCAboutBox* FAboutBox;
	TGradientDirection FGradientDirection;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	TCoolChangeLink* FCoolImagesChangeLink;
	TTransparencyIntense FTransparencyIntense;
	Windows::TRect FDragRect;
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	virtual void __fastcall SetOptions(TCoolOptions Value);
	void __fastcall SetStartColor(Graphics::TColor Value);
	void __fastcall SetEndColor(Graphics::TColor Value);
	void __fastcall SetGradientDirection(TGradientDirection Value);
	void __fastcall SetTransparencyIntense(TTransparencyIntense Value);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	bool __fastcall FormAssigned(void);
	
protected:
	TCoolForm* Form;
	void __fastcall BeforeMessage(System::TObject* Sender, Messages::TMessage &Msg, bool &Handled);
	void __fastcall AfterMessage(System::TObject* Sender, Messages::TMessage &Msg, bool &Handled);
	void __fastcall ChangeControl(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TCoolFormHook(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolFormHook(void);
	__property Windows::TRect DragRect = {read=FDragRect, write=FDragRect};
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property Graphics::TColor EndColor = {read=FEndColor, write=SetEndColor, default=0};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection
		, default=1};
	__property TCoolOptions Options = {read=FOptions, write=SetOptions, default=0};
	__property int RoundXOffset = {read=FRoundXOffset, write=FRoundXOffset, default=0};
	__property int RoundYOffset = {read=FRoundYOffset, write=FRoundYOffset, default=0};
	__property Graphics::TColor StartColor = {read=FStartColor, write=SetStartColor, default=16711680};
		
	__property TTransparencyIntense TransparencyIntense = {read=FTransparencyIntense, write=SetTransparencyIntense
		, default=128};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
};

#pragma pack(pop)

class DELPHICLASS TMDICoolFormHook;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TMDICoolFormHook : public TCoolFormHook 
{
	typedef TCoolFormHook inherited;
	
private:
	void *FDefProc;
	void *FNewProc;
	Classes::TNotifyEvent FOldChildPaint;
	virtual void __fastcall SetOptions(TCoolOptions Value);
	void __fastcall HookWndProc(HWND AHandle);
	void __fastcall UnHookWndProc(HWND AHandle);
	void __fastcall HookedPaint(System::TObject* Sender);
	
protected:
	virtual void __fastcall ClientWndProc(Messages::TMessage &Message);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TMDICoolFormHook(Classes::TComponent* AOwner);
	__fastcall virtual ~TMDICoolFormHook(void);
};

#pragma pack(pop)

#pragma option push -b-
enum TBtnPaintOption { bpoDrawFocus, bpoDrawDefault };
#pragma option pop

typedef Set<TBtnPaintOption, bpoDrawFocus, bpoDrawDefault>  TBtnPaintOptions;

class DELPHICLASS TCoolBtn;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolBtn : public Stdctrls::TButton 
{
	typedef Stdctrls::TButton inherited;
	
private:
	bool IsFocused;
	Graphics::TCanvas* FCanvas;
	void *FGlyph;
	Graphics::TBitmap* FWallpaper;
	TCoolOptions FOptions;
	Buttons::TButtonLayout FLayout;
	int FSpacing;
	int FMargin;
	Controls::TImageList* FImages;
	Imglist::TChangeLink* FImageChangeLink;
	unsigned FInterval;
	bool FAnimated;
	int FImageIndex;
	Extctrls::TTimer* FTimer;
	TCCAboutBox* FAboutBox;
	Graphics::TColor FShadowColor;
	Byte FShadowSize;
	Coolutils::TShadowPosition FShadowPos;
	bool FSimpleView;
	Byte FTransparencyLevel;
	Graphics::TColor FColorStart;
	Graphics::TColor FColorEnd;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	TCoolChangeLink* FCoolImagesChangeLink;
	TGradientDirection FGradientDirection;
	TDrawButtonEvent FOnDrawButton;
	bool FMouseInControl;
	TBtnPaintOptions FBtnPaintOptions;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall SetOptions(TCoolOptions Value);
	void __fastcall SetShadowColor(Graphics::TColor Value);
	void __fastcall SetShadowSize(Byte Value);
	void __fastcall SetShadowPos(Coolutils::TShadowPosition Value);
	void __fastcall SetSimpleView(bool Value);
	void __fastcall SetGlyph(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetLayout(Buttons::TButtonLayout Value);
	Buttons::TNumGlyphs __fastcall GetNumGlyphs(void);
	void __fastcall SetNumGlyphs(Buttons::TNumGlyphs Value);
	void __fastcall SetSpacing(int Value);
	void __fastcall SetMargin(int Value);
	void __fastcall SetImages(Controls::TImageList* Value);
	void __fastcall SetInterval(unsigned Value);
	void __fastcall SetAnimated(bool Value);
	void __fastcall SetTransparencyLevel(Byte Value);
	void __fastcall SetColorStart(Graphics::TColor Value);
	void __fastcall SetColorEnd(Graphics::TColor Value);
	void __fastcall SetGradientDirection(TGradientDirection Value);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	MESSAGE void __fastcall CNMeasureItem(Messages::TWMMeasureItem &Message);
	MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Messages::TMessage &Message);
	void __fastcall UpdateTimer(System::TObject* Sender);
	void __fastcall DrawItem(const tagDRAWITEMSTRUCT &DrawItemStruct);
	void __fastcall DrawItemRect(const tagDRAWITEMSTRUCT &DrawItemStruct);
	void __fastcall DrawItemCircle(const tagDRAWITEMSTRUCT &DrawItemStruct);
	void __fastcall GlyphChanged(System::TObject* Sender);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall ImageListChange(System::TObject* Sender);
	
protected:
	bool ForcedFlat;
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall SetButtonStyle(bool ADefault);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TCoolBtn(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolBtn(void);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property bool Animated = {read=FAnimated, write=SetAnimated, default=0};
	__property TBtnPaintOptions BtnPaintOptions = {read=FBtnPaintOptions, write=FBtnPaintOptions, default=3
		};
	__property Graphics::TColor ColorEnd = {read=FColorEnd, write=SetColorEnd, default=-2147483632};
	__property Graphics::TColor ColorStart = {read=FColorStart, write=SetColorStart, default=-2147483633
		};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection
		, default=0};
	__property Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property unsigned Interval = {read=FInterval, write=SetInterval, default=1000};
	__property TCoolOptions Options = {read=FOptions, write=SetOptions, default=0};
	__property Buttons::TButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property int Margin = {read=FMargin, write=SetMargin, default=-1};
	__property Buttons::TNumGlyphs NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, default=1};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=-2147483628
		};
	__property Byte ShadowSize = {read=FShadowSize, write=SetShadowSize, default=1};
	__property Coolutils::TShadowPosition ShadowPos = {read=FShadowPos, write=SetShadowPos, default=0};
		
	__property bool SimpleView = {read=FSimpleView, write=SetSimpleView, default=0};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property TDrawButtonEvent OnDrawButton = {read=FOnDrawButton, write=FOnDrawButton};
	__property Color ;
	__property Action ;
	__property Anchors ;
	__property BiDiMode ;
	__property Cancel ;
	__property Caption ;
	__property Constraints ;
	__property Default ;
	__property Enabled ;
	__property ModalResult ;
	__property ParentShowHint ;
	__property ParentBiDiMode ;
	__property ShowHint ;
	__property TabOrder ;
	__property TabStop ;
	__property Visible ;
	__property OnEnter ;
	__property OnExit ;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolBtn(HWND ParentWindow) : Stdctrls::TButton(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

#pragma option push -b-
enum TCaptionBtnType { cbtClose, cbtHelp, cbtMaximize, cbtMinimize, cbtRestore };
#pragma option pop

class DELPHICLASS TCoolCaptionBtn;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolCaptionBtn : public Stdctrls::TButton 
{
	typedef Stdctrls::TButton inherited;
	
private:
	Graphics::TCanvas* FCanvas;
	bool IsFocused;
	TCaptionBtnType FCaptionBtnType;
	TCCAboutBox* FAboutBox;
	void __fastcall SetCaptionBtnType(TCaptionBtnType Value);
	AnsiString __fastcall GetCaption();
	void __fastcall DrawItem(const tagDRAWITEMSTRUCT &DrawItemStruct);
	MESSAGE void __fastcall CNMeasureItem(Messages::TWMMeasureItem &Message);
	MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall SetButtonStyle(bool ADefault);
	
public:
	__fastcall virtual TCoolCaptionBtn(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolCaptionBtn(void);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property TCaptionBtnType CaptionBtnType = {read=FCaptionBtnType, write=SetCaptionBtnType, default=0
		};
	__property AnsiString Caption = {read=GetCaption};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolCaptionBtn(HWND ParentWindow) : Stdctrls::TButton(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

#pragma option push -b-
enum TTrackOrientation { toHorizontal, toVertical };
#pragma option pop

#pragma option push -b-
enum TPaintOption { poDrawFocusRect, poDrawTrackBar, poDrawTicks, poDrawThumb, poDrawThumbStates };
#pragma option pop

typedef Set<TPaintOption, poDrawFocusRect, poDrawThumbStates>  TPaintOptions;

class DELPHICLASS TCoolTrackBar;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolTrackBar : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	TTrackOrientation FOrientation;
	int FMinValue;
	int FMaxValue;
	int FPosition;
	Graphics::TBitmap* FThumbHorz;
	Graphics::TBitmap* FThumbVert;
	Graphics::TBitmap* FThumbHorzSelected;
	Graphics::TBitmap* FThumbVertSelected;
	Graphics::TBitmap* FThumbImage;
	Windows::TRect FThumbRect;
	Windows::TRect FTrackRect;
	Comctrls::TTickMark FTickMarks;
	int FBarSize;
	Graphics::TColor FBarColor;
	int FBorderWidth;
	Word FPageSize;
	bool FSliding;
	Controls::TBevelCut FBevelInner;
	Controls::TBevelCut FBevelOuter;
	bool FTransparentThumb;
	TCoolOptions FOptions;
	TPaintOptions FPaintOptions;
	Graphics::TBitmap* FWallpaper;
	Byte FTransparencyLevel;
	TCCAboutBox* FAboutBox;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	TCoolChangeLink* FCoolImagesChangeLink;
	Classes::TNotifyEvent FOnChange;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	void __fastcall SetOrientation(TTrackOrientation Value);
	void __fastcall SetMinValue(int Value);
	void __fastcall SetMaxValue(int Value);
	void __fastcall SetPosition(int Value);
	void __fastcall SetBarSize(int Value);
	void __fastcall SetBarColor(Graphics::TColor Value);
	void __fastcall SetTickMarks(Comctrls::TTickMark Value);
	void __fastcall SetTransparencyLevel(Byte Value);
	Graphics::TBitmap* __fastcall GetThumbHorz(void);
	Graphics::TBitmap* __fastcall GetThumbVert(void);
	Graphics::TBitmap* __fastcall GetThumbHorzSelected(void);
	Graphics::TBitmap* __fastcall GetThumbVertSelected(void);
	void __fastcall SetThumbHorz(Graphics::TBitmap* Value);
	void __fastcall SetThumbVert(Graphics::TBitmap* Value);
	void __fastcall SetThumbHorzSelected(Graphics::TBitmap* Value);
	void __fastcall SetThumbVertSelected(Graphics::TBitmap* Value);
	void __fastcall SetBevelInner(Controls::TBevelCut Value);
	void __fastcall SetBevelOuter(Controls::TBevelCut Value);
	void __fastcall SetTransparentThumb(bool Value);
	void __fastcall SetOptions(TCoolOptions Value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall SetPaintOptions(TPaintOptions Value);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	void __fastcall InvalidateThumb(void);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall LoadImages(void);
	virtual void __fastcall DrawTrack(Graphics::TCanvas* ACanvas);
	virtual void __fastcall DrawTicks(Graphics::TCanvas* ACanvas);
	virtual void __fastcall DrawThumb(Graphics::TCanvas* ACanvas);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int 
		Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TCoolTrackBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolTrackBar(void);
	virtual void __fastcall SetFocus(void);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Graphics::TColor BarColor = {read=FBarColor, write=SetBarColor, default=-2147483643};
	__property int BarSize = {read=FBarSize, write=SetBarSize, default=10};
	__property Controls::TBevelCut BevelInner = {read=FBevelInner, write=SetBevelInner, default=0};
	__property Controls::TBevelCut BevelOuter = {read=FBevelOuter, write=SetBevelOuter, default=0};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property TTrackOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property int MinValue = {read=FMinValue, write=SetMinValue, default=0};
	__property int MaxValue = {read=FMaxValue, write=SetMaxValue, default=10};
	__property TCoolOptions Options = {read=FOptions, write=SetOptions, default=0};
	__property TPaintOptions PaintOptions = {read=FPaintOptions, write=SetPaintOptions, default=31};
	__property Word PageSize = {read=FPageSize, write=FPageSize, default=1};
	__property int Position = {read=FPosition, write=SetPosition, default=0};
	__property Comctrls::TTickMark TickMarks = {read=FTickMarks, write=SetTickMarks, default=0};
	__property Graphics::TBitmap* ThumbHorz = {read=GetThumbHorz, write=SetThumbHorz};
	__property Graphics::TBitmap* ThumbVert = {read=GetThumbVert, write=SetThumbVert};
	__property Graphics::TBitmap* ThumbHorzSelected = {read=GetThumbHorzSelected, write=SetThumbHorzSelected
		};
	__property Graphics::TBitmap* ThumbVertSelected = {read=GetThumbVertSelected, write=SetThumbVertSelected
		};
	__property bool TransparentThumb = {read=FTransparentThumb, write=SetTransparentThumb, default=1};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Action ;
	__property Anchors ;
	__property BiDiMode ;
	__property Caption ;
	__property Color ;
	__property Constraints ;
	__property Ctl3D ;
	__property UseDockManager ;
	__property DockSite ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property Font ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property ShowHint ;
	__property TabOrder ;
	__property TabStop ;
	__property Visible ;
	__property OnCanResize ;
	__property OnClick ;
	__property OnConstrainedResize ;
	__property OnDockDrop ;
	__property OnDockOver ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetSiteInfo ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnUnDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolTrackBar(HWND ParentWindow) : Controls::TCustomControl(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

#pragma option push -b-
enum TCoolThumbTabPosition { tpLeftBottom, tpRightBottom, tpLeftTop, tpRightTop };
#pragma option pop

class DELPHICLASS TCoolThumbTab;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolThumbTab : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	TCCAboutBox* FAboutBox;
	Coolutils::TWndHook* FWindowHook;
	TCoolThumbTabPosition FThumbPosition;
	bool FTransparent;
	Graphics::TBitmap* FWallpaper;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	TCoolChangeLink* FCoolImagesChangeLink;
	bool FStretched;
	void __fastcall SetThumbPosition(TCoolThumbTabPosition Value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall SetTransparent(bool Value);
	void __fastcall SetStretched(bool Value);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	void __fastcall AfterMessage(System::TObject* Sender, Messages::TMessage &Msg, bool &Handled);
	Windows::TRect __fastcall SubRect();
	
protected:
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TCoolThumbTab(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolThumbTab(void);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property TCoolThumbTabPosition ThumbPosition = {read=FThumbPosition, write=SetThumbPosition, default=1
		};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool Stretched = {read=FStretched, write=SetStretched, default=0};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property Anchors ;
	__property Align ;
	__property Enabled ;
	__property Color ;
	__property PopupMenu ;
	__property ParentColor ;
	__property Visible ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnStartDock ;
	__property OnEndDrag ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDrag ;
};

#pragma pack(pop)

class DELPHICLASS TCoolBevel;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolBevel : public Extctrls::TBevel 
{
	typedef Extctrls::TBevel inherited;
	
private:
	TCCAboutBox* FAboutBox;
	Graphics::TColor FColor;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	TCoolChangeLink* FCoolImagesChangeLink;
	bool FTransparent;
	bool FFlat;
	Graphics::TBitmap* FWallpaper;
	bool FStretched;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	HIDESBASE void __fastcall SetColor(Graphics::TColor Value);
	void __fastcall SetTransparent(bool Value);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall SetFlat(bool Value);
	void __fastcall SetStretched(bool Value);
	void __fastcall SetidWallpaper(int Value);
	bool __fastcall IsWallpaperAssigned(void);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TCoolBevel(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolBevel(void);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-2147483633};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property bool Stretched = {read=FStretched, write=SetStretched, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=1};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property OnClick ;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
};

#pragma pack(pop)

class DELPHICLASS TCustomCoolCheckRadioGroup;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCustomCoolCheckRadioGroup : public TCoolGroupBox 
{
	typedef TCoolGroupBox inherited;
	
private:
	TCCAboutBox* FAboutBox;
	Classes::TList* FButtons;
	Classes::TStrings* FItems;
	int FItemIndex;
	int FColumns;
	bool FReading;
	bool FUpdating;
	bool FFlat;
	TCheckRadioType FCheckRadioType;
	Graphics::TBitmap* FGlyphMarked;
	Graphics::TBitmap* FGlyphNormal;
	void __fastcall SetCheckRadioType(TCheckRadioType Value);
	void __fastcall SetButtonCount(int Value);
	void __fastcall SetColumns(int Value);
	void __fastcall SetItemIndex(int Value);
	void __fastcall SetItems(Classes::TStrings* Value);
	void __fastcall SetGlyphNormal(Graphics::TBitmap* Value);
	void __fastcall SetFlat(bool Value);
	Graphics::TBitmap* __fastcall GetGlyphNormal(void);
	void __fastcall SetGlyphMarked(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetGlyphMarked(void);
	void __fastcall ArrangeButtons(void);
	void __fastcall ButtonClick(System::TObject* Sender);
	void __fastcall ItemsChange(System::TObject* Sender);
	void __fastcall UpdateButtons(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMChanged(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual void __fastcall Loaded(void);
	__property TCheckRadioType CheckRadioType = {read=FCheckRadioType, write=SetCheckRadioType, default=1
		};
	__property int Columns = {read=FColumns, write=SetColumns, default=1};
	__property Graphics::TBitmap* GlyphMarked = {read=GetGlyphMarked, write=SetGlyphMarked};
	__property Graphics::TBitmap* GlyphNormal = {read=GetGlyphNormal, write=SetGlyphNormal};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=-1};
	__property Classes::TStrings* Items = {read=FItems, write=SetItems};
	
public:
	__fastcall virtual TCustomCoolCheckRadioGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomCoolCheckRadioGroup(void);
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCustomCoolCheckRadioGroup(HWND ParentWindow) : 
		TCoolGroupBox(ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolCheckRadioGroup;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolCheckRadioGroup : public TCustomCoolCheckRadioGroup 
{
	typedef TCustomCoolCheckRadioGroup inherited;
	
__published:
	__property CheckRadioType ;
	__property Columns ;
	__property GlyphMarked ;
	__property GlyphNormal ;
	__property Flat ;
	__property ItemIndex ;
	__property Items ;
public:
	#pragma option push -w-inl
	/* TCustomCoolCheckRadioGroup.Create */ inline __fastcall virtual TCoolCheckRadioGroup(Classes::TComponent* 
		AOwner) : TCustomCoolCheckRadioGroup(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomCoolCheckRadioGroup.Destroy */ inline __fastcall virtual ~TCoolCheckRadioGroup(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolCheckRadioGroup(HWND ParentWindow) : TCustomCoolCheckRadioGroup(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

#pragma option push -b-
enum TButtonStateEx { bseDownBoth, bseDownAdd, bseUpBoth, bseNoneBoth };
#pragma option pop

class DELPHICLASS TCustomPopupButton;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCustomPopupButton : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	TButtonStateEx FButtonStateEx;
	TCCAboutBox* FAboutBox;
	int FBtnAddSize;
	void *FGlyph;
	Buttons::TButtonLayout FLayout;
	int FSpacing;
	int FMargin;
	Graphics::TColor FShadowColor;
	Byte FShadowSize;
	Coolutils::TShadowPosition FShadowPos;
	bool FSimpleView;
	bool FStretched;
	bool FFlat;
	bool FTransparent;
	TCoolChangeLink* FCoolImagesChangeLink;
	Graphics::TBitmap* FWallPaper;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	void __fastcall SetGlyph(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetLayout(Buttons::TButtonLayout Value);
	Buttons::TNumGlyphs __fastcall GetNumGlyphs(void);
	void __fastcall SetNumGlyphs(Buttons::TNumGlyphs Value);
	void __fastcall SetSpacing(int Value);
	void __fastcall SetMargin(int Value);
	void __fastcall GlyphChanged(System::TObject* Sender);
	void __fastcall SetWallPaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	bool __fastcall IsWallpaperAssigned(void);
	void __fastcall SetidWallpaper(int Value);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	void __fastcall SetShadowColor(Graphics::TColor Value);
	void __fastcall SetShadowSize(Byte Value);
	void __fastcall SetShadowPos(Coolutils::TShadowPosition Value);
	void __fastcall SetSimpleView(bool Value);
	void __fastcall SetStretched(bool Value);
	void __fastcall SetFlat(bool Value);
	void __fastcall SetTransparent(bool Value);
	void __fastcall SetBtnAddSize(int Value);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMHitTest(Messages::TWMNCHitTest &Message);
	MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	
protected:
	unsigned Handle;
	__property TButtonStateEx ButtonStateEx = {read=FButtonStateEx, write=FButtonStateEx, nodefault};
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int 
		Y);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall ClickAdd(void);
	
public:
	__fastcall virtual TCustomPopupButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomPopupButton(void);
	__property int BtnAddSize = {read=FBtnAddSize, write=SetBtnAddSize, default=16};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property Buttons::TButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property int Margin = {read=FMargin, write=SetMargin, default=-1};
	__property Buttons::TNumGlyphs NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, default=1};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=-2147483628
		};
	__property Byte ShadowSize = {read=FShadowSize, write=SetShadowSize, default=1};
	__property Coolutils::TShadowPosition ShadowPos = {read=FShadowPos, write=SetShadowPos, default=0};
		
	__property bool SimpleView = {read=FSimpleView, write=SetSimpleView, default=0};
	__property bool Stretched = {read=FStretched, write=SetStretched, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallPaper};
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
};

#pragma pack(pop)

class DELPHICLASS TCoolPopupButton;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolPopupButton : public TCustomPopupButton 
{
	typedef TCustomPopupButton inherited;
	
private:
	Menus::TPopupMenu* FDownMenu;
	
protected:
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall ClickAdd(void);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property Menus::TPopupMenu* DownMenu = {read=FDownMenu, write=FDownMenu};
	__property BtnAddSize ;
	__property CoolImages ;
	__property idWallpaper ;
	__property Flat ;
	__property Glyph ;
	__property Layout ;
	__property Margin ;
	__property NumGlyphs ;
	__property PopupMenu ;
	__property Spacing ;
	__property ShadowColor ;
	__property ShadowSize ;
	__property ShadowPos ;
	__property SimpleView ;
	__property Transparent ;
	__property Wallpaper ;
	__property Action ;
	__property Anchors ;
	__property BiDiMode ;
	__property Caption ;
	__property Color ;
	__property Constraints ;
	__property Enabled ;
	__property Font ;
	__property ParentColor ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property ParentBiDiMode ;
	__property ShowHint ;
	__property Visible ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnMouseDown ;
	__property OnMouseUp ;
	__property OnMouseMove ;
public:
	#pragma option push -w-inl
	/* TCustomPopupButton.Create */ inline __fastcall virtual TCoolPopupButton(Classes::TComponent* AOwner
		) : TCustomPopupButton(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomPopupButton.Destroy */ inline __fastcall virtual ~TCoolPopupButton(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolListBoxEx;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolListBoxEx : public TCoolListBox 
{
	typedef TCoolListBox inherited;
	
private:
	bool CanClose;
	MESSAGE void __fastcall WMMouseActivate(Messages::TWMMouseActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	
protected:
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int 
		Y);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall Click(void);
public:
	#pragma option push -w-inl
	/* TCoolListBox.Create */ inline __fastcall virtual TCoolListBoxEx(Classes::TComponent* AOwner) : TCoolListBox(
		AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCoolListBox.Destroy */ inline __fastcall virtual ~TCoolListBoxEx(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolListBoxEx(HWND ParentWindow) : TCoolListBox(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolPopupBox;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolPopupBox : public TCustomPopupButton 
{
	typedef TCustomPopupButton inherited;
	
private:
	TCoolListBoxEx* FListBox;
	bool FMouseAction;
	Forms::TMessageEvent FPrevMessage;
	Classes::TNotifyEvent FOnChange;
	Classes::TStrings* __fastcall GetItems(void);
	void __fastcall SetItems(Classes::TStrings* Value);
	int __fastcall GetItemIndex(void);
	void __fastcall SetItemIndex(int Value);
	void __fastcall AppMessage(tagMSG &Msg, bool &Handled);
	bool __fastcall IsCloseMsg(tagMSG &Msg);
	void __fastcall Change(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	
protected:
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int 
		Y);
	virtual void __fastcall ClickAdd(void);
	DYNAMIC void __fastcall Click(void);
	
public:
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	__fastcall virtual TCoolPopupBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolPopupBox(void);
	
__published:
	__property Classes::TStrings* Items = {read=GetItems, write=SetItems};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property BtnAddSize ;
	__property CoolImages ;
	__property idWallpaper ;
	__property Flat ;
	__property Glyph ;
	__property Layout ;
	__property Margin ;
	__property NumGlyphs ;
	__property PopupMenu ;
	__property Spacing ;
	__property ShadowColor ;
	__property ShadowSize ;
	__property ShadowPos ;
	__property SimpleView ;
	__property Transparent ;
	__property Wallpaper ;
	__property Action ;
	__property Anchors ;
	__property BiDiMode ;
	__property Caption ;
	__property Color ;
	__property Constraints ;
	__property Enabled ;
	__property Font ;
	__property ParentColor ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property ParentBiDiMode ;
	__property ShowHint ;
	__property Visible ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnMouseDown ;
	__property OnMouseUp ;
	__property OnMouseMove ;
};

#pragma pack(pop)

class DELPHICLASS TCoolPopupButton2;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolPopupButton2 : public TCoolBtn 
{
	typedef TCoolBtn inherited;
	
private:
	Menus::TPopupMenu* FDownMenu;
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	
public:
	__fastcall virtual TCoolPopupButton2(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property Menus::TPopupMenu* DownMenu = {read=FDownMenu, write=FDownMenu};
public:
	#pragma option push -w-inl
	/* TCoolBtn.Destroy */ inline __fastcall virtual ~TCoolPopupButton2(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolPopupButton2(HWND ParentWindow) : TCoolBtn(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolPopupBox2;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolPopupBox2 : public TCoolBtn 
{
	typedef TCoolBtn inherited;
	
private:
	TCoolListBoxEx* FListBox;
	Forms::TMessageEvent FPrevMessage;
	Classes::TNotifyEvent FOnChange;
	Classes::TStrings* __fastcall GetItems(void);
	void __fastcall SetItems(Classes::TStrings* Value);
	int __fastcall GetItemIndex(void);
	void __fastcall SetItemIndex(int Value);
	void __fastcall AppMessage(tagMSG &Msg, bool &Handled);
	bool __fastcall IsCloseMsg(tagMSG &Msg);
	void __fastcall Change(System::TObject* Sender);
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	__fastcall virtual TCoolPopupBox2(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolPopupBox2(void);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property Classes::TStrings* Items = {read=GetItems, write=SetItems};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolPopupBox2(HWND ParentWindow) : TCoolBtn(ParentWindow
		) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolSpeedButton;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolSpeedButton : public Buttons::TSpeedButton 
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	TCCAboutBox* FAboutBox;
	bool FDowned;
	Graphics::TColor FBkColor;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	
protected:
	bool HasMouse;
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int 
		Y);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	
public:
	__fastcall virtual TCoolSpeedButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolSpeedButton(void);
	__property bool Downed = {read=FDowned, nodefault};
	__property Graphics::TColor BkColor = {read=FBkColor, default=-2147483632};
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
};

#pragma pack(pop)

class DELPHICLASS TCoolPanel;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolPanel : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Graphics::TBitmap* FWallpaper;
	bool FTransparent;
	Byte FTransparencyLevel;
	TCCAboutBox* FAboutBox;
	bool FStretched;
	TCoolImages* FCoolImages;
	int FidWallpaper;
	TCoolChangeLink* FCoolImagesChangeLink;
	Graphics::TColor FInactiveFontColor;
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	void __fastcall SetTransparent(bool Value);
	void __fastcall SetTransparencyLevel(Byte Value);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall SetStretched(bool Value);
	void __fastcall SetCoolImages(TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	void __fastcall SetInactiveFontColor(Graphics::TColor Value);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TCoolPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolPanel(void);
	__property DockManager ;
	
__published:
	__property TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property Graphics::TColor InactiveFontColor = {read=FInactiveFontColor, write=SetInactiveFontColor
		, default=16777215};
	__property bool Stretched = {read=FStretched, write=SetStretched, default=0};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property Align ;
	__property Alignment ;
	__property Anchors ;
	__property AutoSize ;
	__property BevelInner ;
	__property BevelOuter ;
	__property BevelWidth ;
	__property BiDiMode ;
	__property BorderWidth ;
	__property BorderStyle ;
	__property Caption ;
	__property Color ;
	__property Constraints ;
	__property Ctl3D ;
	__property UseDockManager ;
	__property DockSite ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property FullRepaint ;
	__property Font ;
	__property Locked ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder ;
	__property TabStop ;
	__property Visible ;
	__property OnCanResize ;
	__property OnClick ;
	__property OnConstrainedResize ;
	__property OnDockDrop ;
	__property OnDockOver ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetSiteInfo ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnStartDrag ;
	__property OnStartDock ;
	__property OnUnDock ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolPanel(HWND ParentWindow) : Extctrls::TCustomPanel(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TCoolButtonPanel;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TCoolButtonPanel : public TCoolPanel 
{
	typedef TCoolPanel inherited;
	
private:
	int FButtonWidth;
	int FButtonHeight;
	Classes::TList* FButtons;
	Buttons::TSpeedButton* FScrollUpBtn;
	Buttons::TSpeedButton* FScrollDownBtn;
	Classes::TNotifyEvent FOnScrollDown;
	Classes::TNotifyEvent FOnScrollUp;
	TCoolSpeedButton* __fastcall GetButton(int Index);
	int __fastcall GetButtonCount(void);
	void __fastcall SetButtonWidth(int Value);
	void __fastcall SetButtonHeight(int Value);
	void __fastcall ScrollUp(System::TObject* Sender);
	void __fastcall ScrollDown(System::TObject* Sender);
	MESSAGE void __fastcall CMButtonDestroyed(Messages::TMessage &Message);
	MESSAGE void __fastcall CMButtonMouseUp(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	MESSAGE void __fastcall CMMouseCaptureChange(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	
public:
	__fastcall virtual TCoolButtonPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolButtonPanel(void);
	TCoolSpeedButton* __fastcall CreateButton(void);
	void __fastcall ReorderButtons(void);
	void __fastcall ScrollByEx(int DeltaX, int DeltaY, const Windows::TRect &R);
	__property TCoolSpeedButton* Buttons[int Index] = {read=GetButton};
	__property int ButtonsCount = {read=GetButtonCount, nodefault};
	__property DockManager ;
	
__published:
	__property int ButtonHeight = {read=FButtonHeight, write=SetButtonHeight, default=64};
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, default=64};
	__property BevelOuter ;
	__property Color ;
	__property UseDockManager ;
	__property Classes::TNotifyEvent OnScrollDown = {read=FOnScrollDown, write=FOnScrollDown};
	__property Classes::TNotifyEvent OnScrollUp = {read=FOnScrollUp, write=FOnScrollUp};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCoolButtonPanel(HWND ParentWindow) : TCoolPanel(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

typedef Classes::TIdentMapEntry CoolCtrls__83[15];

//-- var, const, procedure ---------------------------------------------------
static const Word CM_ENDEDITING = 0x594;
static const Word CM_BUTTONDESTROYED = 0x595;
static const Word CM_BUTTONMOUSEUP = 0x596;
static const Word CM_PARENTBACKCOLOR = 0x597;
static const Word CM_MOUSECAPTURECHANGE = 0x598;
static const Word CM_PAINTLISTBOXPART = 0x599;
static const Word CM_TRAYICONEVENT = 0x59a;
extern PACKAGE Classes::TIdentMapEntry CopyModes[15];
extern PACKAGE bool __fastcall IsCoolControl(const System::TObject* Obj);
extern PACKAGE void __fastcall DrawFlatBorder(HDC DC, Controls::TWinControl* Control, bool InCtrl);
extern PACKAGE void __fastcall DrawBorders(HDC DC, Controls::TWinControl* Control, Toolwin::TEdgeBorders 
	Borders, Graphics::TPen* Pen, Graphics::TColor BkColor);
extern PACKAGE void __fastcall GetCopyModeValues(Classes::TGetStrProc Proc);

}	/* namespace Coolctrls */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Coolctrls;
#endif
#pragma option pop	// -w-

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolCtrls
