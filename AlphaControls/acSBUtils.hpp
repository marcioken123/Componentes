// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acSBUtils.pas' rev: 27.00 (Windows)

#ifndef AcsbutilsHPP
#define AcsbutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Grids.hpp>	// Pascal unit
#include <Winapi.CommCtrl.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <System.TypInfo.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sSkinManager.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acsbutils
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TDropMarkMode : unsigned char { dmmNone, dmmLeft, dmmRight };

enum DECLSPEC_DENUM Acsbutils__1 : unsigned char { hpeBackground, hpeDropMark, hpeHeaderGlyph, hpeSortGlyph, hpeText };

typedef System::Set<Acsbutils__1, Acsbutils__1::hpeBackground, Acsbutils__1::hpeText> THeaderPaintElements;

struct DECLSPEC_DRECORD TacSkinParams
{
public:
	Vcl::Controls::TControl* Control;
	System::UnicodeString SkinSection;
	bool UseSkinFontColor;
	bool UseSkinColor;
	int VertScrollSize;
	int VertScrollBtnSize;
	int HorzScrollSize;
	int HorzScrollBtnSize;
};


struct DECLSPEC_DRECORD THeaderPaintInfo
{
public:
	Vcl::Graphics::TCanvas* TargetCanvas;
	System::Classes::TCollectionItem* Column;
	System::Types::TRect PaintRectangle;
	System::Types::TRect TextRectangle;
	bool IsHoverIndex;
	bool IsDownIndex;
	bool IsEnabled;
	bool ShowHeaderGlyph;
	bool ShowSortGlyph;
	bool ShowRightBorder;
	TDropMarkMode DropMark;
	System::Types::TPoint GlyphPos;
	System::Types::TPoint SortGlyphPos;
};


class DELPHICLASS TacScrollBar;
class DELPHICLASS TacScrollWnd;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacScrollBar : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	System::Word fScrollFlags;
	int nArrowLength;
	int nArrowWidth;
	int nButSizeBefore;
	int nButSizeAfter;
	bool fButVisibleBefore;
	bool fButVisibleAfter;
	System::Word nBarType;
	int nMinThumbSize;
	TacScrollWnd* sw;
	
public:
	bool fScrollVisible;
	tagSCROLLINFO ScrollInfo;
	__fastcall TacScrollBar(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TacScrollBar(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TacSpeedButtonHandler;
class PASCALIMPLEMENTATION TacSpeedButtonHandler : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	Vcl::Controls::TControl* Ctrl;
	Vcl::Controls::TControl* *PCtrl;
	System::Classes::TWndMethod OldWndProc;
	Sskinmanager::TsSkinManager* SkinManager;
	Scommondata::TsCommonData* SkinData;
	bool Destroyed;
	__fastcall virtual TacSpeedButtonHandler(Vcl::Controls::TControl* Btn, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const System::UnicodeString SkinSection, bool Repaint);
	__fastcall virtual ~TacSpeedButtonHandler(void);
	NativeInt __fastcall CallPrevWndProc(const int Msg, const NativeUInt WParam, NativeInt &lParam);
	void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMPaint(Winapi::Messages::TWMPaint &Message);
	bool __fastcall PrepareCache(void);
	void __fastcall DrawCaption(void);
	void __fastcall DrawGlyph(void);
	System::UnicodeString __fastcall Caption(void);
	System::Types::TRect __fastcall ImgRect(void);
	int __fastcall GlyphHeight(void);
	System::Types::TRect __fastcall CaptionRect(void);
	System::Types::TSize __fastcall TextRectSize(void);
	int __fastcall GlyphWidth(void);
	void __fastcall DoDrawText(const System::Types::TRect &Rect, int Flags);
	int __fastcall CurrentState(void);
};


class DELPHICLASS TacMainWnd;
class PASCALIMPLEMENTATION TacMainWnd : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	bool DlgMode;
	System::UnicodeString Caption;
	System::Types::TRect WndRect;
	System::Types::TSize WndSize;
	System::Types::TPoint WndPos;
	System::Types::TRect ParentRect;
	HWND ParentWnd;
	Vcl::Controls::TControlStyle OldCtrlStyle;
	System::Classes::TWndMethod OldWndProc;
	void *OldProc;
	HWND CtrlHandle;
	Sskinmanager::TsSkinManager* SkinManager;
	bool DontRepaint;
	bool ParamsChanged;
	System::Uitypes::TColor StdColor;
	System::Uitypes::TColor StdFontColor;
	bool Destroyed;
	bool OwnSkinData;
	Scommondata::TsCommonData* SkinData;
	void *NewWndProcInstance;
	int Tag;
	virtual void __fastcall AfterCreation(void);
	__fastcall virtual TacMainWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint);
	virtual void __fastcall SaveStdParams(void);
	virtual void __fastcall RestoreStdParams(void);
	virtual void __fastcall SetSkinParams(void);
	virtual void __fastcall InitSkinData(void);
	__fastcall virtual ~TacMainWnd(void);
	NativeInt __fastcall CallPrevWndProc(const HWND Handle, const int Msg, const NativeUInt WParam, NativeInt &LParam);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
};


class DELPHICLASS TacSBWnd;
class PASCALIMPLEMENTATION TacSBWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
private:
	int FBar1State;
	int FBar2State;
	int FBtn1State;
	int FBtn2State;
	int FSliderState;
	tagSCROLLINFO FSI;
	int FCurrPos;
	void __fastcall SetInteger(const int Index, const int Value);
	
public:
	Vcl::Stdctrls::TScrollBar* Control;
	System::Types::TRect FBtn1Rect;
	System::Types::TRect FBtn2Rect;
	System::Types::TRect FBar1Rect;
	System::Types::TRect FBar2Rect;
	System::Types::TRect FSliderRect;
	Sconst::TCacheInfo CI;
	System::Types::TPoint p;
	bool FRepainting;
	int FLockCount;
	int MouseOffset;
	int ScrollCode;
	System::Types::TRect __fastcall Bar1Rect(void);
	System::Types::TRect __fastcall Bar2Rect(void);
	System::Types::TRect __fastcall Btn1Rect(void);
	System::Types::TRect __fastcall Btn2Rect(void);
	bool __fastcall BarIsHot(void);
	System::Types::TRect __fastcall SliderRect(void);
	int __fastcall SliderSize(void);
	int __fastcall WorkSize(void);
	int __fastcall PositionToCoord(void);
	void __fastcall DrawSlider(Vcl::Graphics::TBitmap* b);
	int __fastcall SysBtnSize(void);
	int __fastcall CoordToPosition(const System::Types::TPoint &p);
	void __fastcall UpdateBar(void);
	void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	virtual void __fastcall AfterCreation(void);
	void __fastcall InitScrollData(void);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	void __fastcall CMMouseLeave(void);
	void __fastcall CMMouseEnter(void);
	void __fastcall LMouseDown(const int X, const int Y);
	void __fastcall LMouseUp(const int X, const int Y);
	__property int Bar1State = {read=FBar1State, write=SetInteger, index=2, nodefault};
	__property int Bar2State = {read=FBar2State, write=SetInteger, index=3, nodefault};
	__property int Btn1State = {read=FBtn1State, write=SetInteger, index=0, nodefault};
	__property int Btn2State = {read=FBtn2State, write=SetInteger, index=1, nodefault};
	__property int SliderState = {read=FSliderState, write=SetInteger, index=4, nodefault};
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacSBWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacSBWnd(void) { }
	
};


class DELPHICLASS TacStaticWnd;
class PASCALIMPLEMENTATION TacStaticWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	virtual void __fastcall AfterCreation(void);
	virtual void __fastcall AC_WMPaint(Winapi::Messages::TWMPaint &Message);
	virtual bool __fastcall PaintText(void);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacStaticWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacStaticWnd(void) { }
	
};


class DELPHICLASS TacEdgeWnd;
class PASCALIMPLEMENTATION TacEdgeWnd : public TacStaticWnd
{
	typedef TacStaticWnd inherited;
	
public:
	virtual void __fastcall AC_WMPaint(Winapi::Messages::TWMPaint &Message);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacEdgeWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacStaticWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacEdgeWnd(void) { }
	
};


class DELPHICLASS TacIconWnd;
class PASCALIMPLEMENTATION TacIconWnd : public TacStaticWnd
{
	typedef TacStaticWnd inherited;
	
public:
	bool IsBmp;
	Vcl::Graphics::TBitmap* FBmp;
	virtual void __fastcall AfterCreation(void);
	__fastcall virtual ~TacIconWnd(void);
	virtual bool __fastcall PaintText(void);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacIconWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacStaticWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
};


class DELPHICLASS TacLinkWnd;
class PASCALIMPLEMENTATION TacLinkWnd : public TacStaticWnd
{
	typedef TacStaticWnd inherited;
	
public:
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	virtual bool __fastcall PaintText(void);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacLinkWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacStaticWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacLinkWnd(void) { }
	
};


class DELPHICLASS TacBtnWnd;
class PASCALIMPLEMENTATION TacBtnWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	virtual void __fastcall AfterCreation(void);
	unsigned __fastcall CtrlStyle(void);
	bool __fastcall Down(void);
	virtual int __fastcall CurrentState(void);
	void __fastcall DrawCaption(void);
	virtual void __fastcall DrawGlyph(void);
	virtual System::Types::TSize __fastcall GlyphSize(void);
	void __fastcall DoDrawText(System::Types::TRect &Rect, const int Flags);
	virtual System::Types::TRect __fastcall CaptionRect(void);
	virtual int __fastcall MaxCaptionWidth(void);
	System::Types::TSize __fastcall TextRectSize(void);
	void __fastcall PrepareCache(void);
	void __fastcall AC_WMPaint(const Winapi::Messages::TWMPaint &Message);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall Repaint(void);
	virtual void __fastcall RestoreStdParams(void);
	virtual void __fastcall SetSkinParams(void);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacBtnWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacBtnWnd(void) { }
	
};


class DELPHICLASS TacBitBtnWnd;
class PASCALIMPLEMENTATION TacBitBtnWnd : public TacBtnWnd
{
	typedef TacBtnWnd inherited;
	
public:
	virtual int __fastcall CurrentState(void);
	virtual System::Types::TRect __fastcall CaptionRect(void);
	System::Types::TRect __fastcall GlyphRect(void);
	virtual System::Types::TSize __fastcall GlyphSize(void);
	virtual void __fastcall DrawGlyph(void);
	virtual int __fastcall MaxCaptionWidth(void);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacBitBtnWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacBtnWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacBitBtnWnd(void) { }
	
};


class DELPHICLASS TacButtonWnd;
class PASCALIMPLEMENTATION TacButtonWnd : public TacBtnWnd
{
	typedef TacBtnWnd inherited;
	
public:
	Vcl::Stdctrls::TButton* Btn;
	bool __fastcall HaveImage(void);
	virtual System::Types::TRect __fastcall CaptionRect(void);
	int __fastcall GlyphIndex(void);
	System::Types::TRect __fastcall GlyphRect(void);
	virtual System::Types::TSize __fastcall GlyphSize(void);
	virtual void __fastcall DrawGlyph(void);
	virtual void __fastcall AfterCreation(void);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacButtonWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacBtnWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacButtonWnd(void) { }
	
};


class DELPHICLASS TacSizerWnd;
class PASCALIMPLEMENTATION TacSizerWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	virtual void __fastcall AfterCreation(void);
	void __fastcall AC_WMPaint(const Winapi::Messages::TWMPaint &Message);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacSizerWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacSizerWnd(void) { }
	
};


class DELPHICLASS TacSpinWnd;
class PASCALIMPLEMENTATION TacSpinWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	int lOffset;
	bool bMousePressed;
	int Btn1State;
	int Btn2State;
	bool __fastcall IsVertical(void);
	virtual void __fastcall AfterCreation(void);
	void __fastcall PrepareCache(void);
	void __fastcall AC_WMPaint(const Winapi::Messages::TWMPaint &Message);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacSpinWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacSpinWnd(void) { }
	
};


typedef System::DynamicArray<System::Types::TPoint> TAPoint;

class DELPHICLASS TacTrackWnd;
class PASCALIMPLEMENTATION TacTrackWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	bool bMousePressed;
	int TrackBarNdx;
	int TickHeight;
	double iStep;
	bool __fastcall IsVertical(void);
	virtual void __fastcall AfterCreation(void);
	void __fastcall PrepareCache(void);
	void __fastcall PaintBody(void);
	void __fastcall PaintBar(void);
	void __fastcall PaintThumb(int i);
	void __fastcall PaintTicksHor(void);
	void __fastcall PaintTicksVer(void);
	void __fastcall PaintTick(const System::Types::TPoint &P, bool Horz);
	Vcl::Comctrls::TTickMark __fastcall TickMarks(void);
	Vcl::Comctrls::TTickStyle __fastcall TickStyle(void);
	int __fastcall TickCount(void);
	TAPoint __fastcall TicksArray(void);
	int __fastcall TickPos(int i);
	System::Types::TRect __fastcall ThumbRect(void);
	System::Types::TRect __fastcall ChannelRect(void);
	int __fastcall Mode(void);
	void __fastcall AC_WMPaint(const Winapi::Messages::TWMPaint &Message);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacTrackWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacTrackWnd(void) { }
	
};


class DELPHICLASS TacCheckBoxWnd;
class PASCALIMPLEMENTATION TacCheckBoxWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	bool OwnerDraw;
	Vcl::Stdctrls::TCheckBoxState __fastcall State(void);
	int __fastcall CtlState(void);
	System::Types::TRect __fastcall CheckRect(void);
	System::Types::TRect __fastcall SkinCheckRect(const int i);
	int __fastcall SkinGlyphWidth(const int i);
	int __fastcall SkinGlyphHeight(const int i);
	void __fastcall DrawCheckText(void);
	void __fastcall DrawSkinGlyph(const int i);
	short __fastcall GlyphMaskIndex(const Vcl::Stdctrls::TCheckBoxState State);
	void __fastcall PrepareCache(void);
	void __fastcall AC_WMPaint(const Winapi::Messages::TWMPaint &Message);
	virtual void __fastcall AfterCreation(void);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacCheckBoxWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacCheckBoxWnd(void) { }
	
};


class DELPHICLASS TacContainerWnd;
class PASCALIMPLEMENTATION TacContainerWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	System::Types::TRect ClientRect;
	int BorderWidth;
	void __fastcall PrepareCache(void);
	virtual void __fastcall AfterCreation(void);
	void __fastcall AC_WMPaint(const Winapi::Messages::TWMPaint &Message);
	void __fastcall AC_WMPrint(const Winapi::Messages::TWMPaint &Message);
	void __fastcall AC_WMNCPaint(const Winapi::Messages::TMessage &Message);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacContainerWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacContainerWnd(void) { }
	
};


class DELPHICLASS TacSearchWnd;
class PASCALIMPLEMENTATION TacSearchWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	System::Types::TRect ClientRect;
	virtual void __fastcall AfterCreation(void);
	void __fastcall PrepareCache(void);
	void __fastcall AC_WMNCPaint(const Winapi::Messages::TMessage &Message);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacSearchWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacSearchWnd(void) { }
	
};


class DELPHICLASS TacToolBarWnd;
class PASCALIMPLEMENTATION TacToolBarWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	System::Types::TRect ClientRect;
	int BorderWidth;
	void __fastcall PrepareCache(void);
	void __fastcall DrawButtons(Vcl::Graphics::TBitmap* const Bmp);
	void __fastcall DrawBtn(const int Index, const System::Types::TRect &R, const HDC DC);
	System::Types::TRect __fastcall GetButtonRect(const int Index);
	int __fastcall Count(void);
	System::Types::TRect __fastcall ButtonRect(const int Index);
	void __fastcall AC_WMPaint(const Winapi::Messages::TWMPaint &Message);
	void __fastcall AC_WMPrint(const Winapi::Messages::TWMPaint &Message);
	void __fastcall AC_WMNCPaint(const Winapi::Messages::TMessage &Message);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacToolBarWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacToolBarWnd(void) { }
	
};


class DELPHICLASS TacTransPanelWnd;
class PASCALIMPLEMENTATION TacTransPanelWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	virtual void __fastcall AfterCreation(void);
	void __fastcall AC_WMPaint(const Winapi::Messages::TWMPaint &Message);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacTransPanelWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacTransPanelWnd(void) { }
	
};


class DELPHICLASS TacGroupBoxWnd;
class PASCALIMPLEMENTATION TacGroupBoxWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	virtual void __fastcall AfterCreation(void);
	System::Types::TRect __fastcall CaptionRect(void);
	void __fastcall PrepareCache(void);
	void __fastcall WriteText(const System::Types::TRect &R);
	void __fastcall AC_WMPaint(const Winapi::Messages::TWMPaint &Message);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacGroupBoxWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacGroupBoxWnd(void) { }
	
};


class DELPHICLASS TacTabWnd;
class PASCALIMPLEMENTATION TacTabWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	System::Types::TRect __fastcall DisplayRect(void);
	void __fastcall PrepareCache(void);
	void __fastcall AC_WMPaint(const Winapi::Messages::TWMPaint &Message);
	void __fastcall AC_WMNCPaint(const Winapi::Messages::TWMPaint &Message);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacTabWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacTabWnd(void) { }
	
};


class PASCALIMPLEMENTATION TacScrollWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	bool ScrollsInitialized;
	TacScrollBar* sBarHorz;
	TacScrollBar* sBarVert;
	bool fThumbTracking;
	bool fLeftScrollbar;
	int cxLeftEdge;
	int cxRightEdge;
	int cyTopEdge;
	int cyBottomEdge;
	bool bPreventStyleChange;
	virtual void __fastcall InitSkinData(void);
	__fastcall virtual ~TacScrollWnd(void);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacScrollWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
};


class DELPHICLASS TacAccessPanel;
class PASCALIMPLEMENTATION TacAccessPanel : public Vcl::Extctrls::TCustomPanel
{
	typedef Vcl::Extctrls::TCustomPanel inherited;
	
public:
	/* TCustomPanel.Create */ inline __fastcall virtual TacAccessPanel(System::Classes::TComponent* AOwner) : Vcl::Extctrls::TCustomPanel(AOwner) { }
	
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TacAccessPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TacAccessPanel(HWND ParentWindow) : Vcl::Extctrls::TCustomPanel(ParentWindow) { }
	
};


class DELPHICLASS TacPanelWnd;
class PASCALIMPLEMENTATION TacPanelWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	TacAccessPanel* Panel;
	virtual void __fastcall AfterCreation(void);
	bool __fastcall PrepareCache(void);
	void __fastcall AC_WMNCPaint(HDC aDC);
	void __fastcall AC_WMPaint(HDC aDC);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall WriteText(const System::Types::TRect &R, Vcl::Graphics::TCanvas* aCanvas = (Vcl::Graphics::TCanvas*)(0x0));
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacPanelWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacPanelWnd(void) { }
	
};


class DELPHICLASS TacStaticTextWnd;
class PASCALIMPLEMENTATION TacStaticTextWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	Vcl::Controls::TWinControl* Control;
	virtual void __fastcall AfterCreation(void);
	bool __fastcall PrepareCache(void);
	void __fastcall AC_WMNCPaint(HDC aDC);
	void __fastcall AC_WMPaint(HDC aDC);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall WriteText(const System::Types::TRect &R, Vcl::Graphics::TCanvas* aCanvas = (Vcl::Graphics::TCanvas*)(0x0));
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacStaticTextWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacStaticTextWnd(void) { }
	
};


class DELPHICLASS TacMnuWnd;
class PASCALIMPLEMENTATION TacMnuWnd : public TacScrollWnd
{
	typedef TacScrollWnd inherited;
	
protected:
	bool Shown;
	
public:
	int RgnChanged;
	void __fastcall PrepareCache(void);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall AfterCreation(void);
public:
	/* TacScrollWnd.Destroy */ inline __fastcall virtual ~TacMnuWnd(void) { }
	
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacMnuWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacScrollWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
};


class DELPHICLASS TacBaseWnd;
class PASCALIMPLEMENTATION TacBaseWnd : public TacScrollWnd
{
	typedef TacScrollWnd inherited;
	
public:
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacScrollWnd.Destroy */ inline __fastcall virtual ~TacBaseWnd(void) { }
	
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacBaseWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacScrollWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
};


class DELPHICLASS TacMDIWnd;
class PASCALIMPLEMENTATION TacMDIWnd : public TacBaseWnd
{
	typedef TacBaseWnd inherited;
	
public:
	Vcl::Forms::TForm* FForm;
	Scommondata::TsCommonData* MDISkinData;
	System::TObject* SkinProvider;
	__fastcall virtual ~TacMDIWnd(void);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall UpdateGraphControls(void);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacMDIWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacBaseWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
};


class DELPHICLASS TacEditWnd;
class PASCALIMPLEMENTATION TacEditWnd : public TacBaseWnd
{
	typedef TacBaseWnd inherited;
	
public:
	System::Types::TRect FClientRect;
	bool SingleLineEdit;
	System::Uitypes::TColor Color;
	System::Uitypes::TColor FocusColor;
	int FrameColor;
	bool CtrlListChanged;
	__fastcall virtual TacEditWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	bool __fastcall HandleAlphaCmd(Winapi::Messages::TMessage &Message);
	virtual void __fastcall SaveStdParams(void);
	virtual void __fastcall SetSkinParams(void);
	virtual void __fastcall RestoreStdParams(void);
	System::Types::TRect __fastcall ClientRect(void);
public:
	/* TacScrollWnd.Destroy */ inline __fastcall virtual ~TacEditWnd(void) { }
	
};


class DELPHICLASS TacScrollBoxWnd;
class PASCALIMPLEMENTATION TacScrollBoxWnd : public TacScrollWnd
{
	typedef TacScrollWnd inherited;
	
public:
	void __fastcall PrepareCache(void);
	void __fastcall AC_WMNCPaint(HDC aDC);
	void __fastcall AC_WMPaint(HDC aDC);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall AfterCreation(void);
public:
	/* TacScrollWnd.Destroy */ inline __fastcall virtual ~TacScrollBoxWnd(void) { }
	
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacScrollBoxWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacScrollWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
};


class DELPHICLASS TacNativePaint;
class PASCALIMPLEMENTATION TacNativePaint : public TacScrollBoxWnd
{
	typedef TacScrollBoxWnd inherited;
	
public:
	virtual void __fastcall AfterCreation(void);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacScrollWnd.Destroy */ inline __fastcall virtual ~TacNativePaint(void) { }
	
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacNativePaint(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacScrollBoxWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
};


class DELPHICLASS TacComboListWnd;
class PASCALIMPLEMENTATION TacComboListWnd : public TacEditWnd
{
	typedef TacEditWnd inherited;
	
public:
	bool Showed;
	bool SimplyBox;
	bool DBScroll;
	virtual void __fastcall AfterCreation(void);
	__fastcall TacComboListWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const System::UnicodeString SkinSection, bool Repaint, bool Simply);
	virtual void __fastcall SetSkinParams(void);
	__fastcall virtual ~TacComboListWnd(void);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacEditWnd.Create */ inline __fastcall virtual TacComboListWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacEditWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
};


class DELPHICLASS TacListViewWnd;
class PASCALIMPLEMENTATION TacListViewWnd : public TacEditWnd
{
	typedef TacEditWnd inherited;
	
public:
	HWND FhWndHeader;
	void *FhHeaderProc;
	void *FhDefHeaderProc;
	int FPressedColumn;
	int HoverColIndex;
	Vcl::Comctrls::TViewStyle __fastcall ViewStyle(void);
	virtual void __fastcall AfterCreation(void);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall RestoreStdParams(void);
	virtual void __fastcall SaveStdParams(void);
	virtual void __fastcall SetSkinParams(void);
	void __fastcall ColumnSkinPaint(const System::Types::TRect &ControlRect, int cIndex, HDC DC);
	int __fastcall AllColWidth(void);
	bool __fastcall HotTrack(void);
	void __fastcall HeaderWndProc(Winapi::Messages::TMessage &Message);
	System::Types::TRect __fastcall GetHeaderColumnRect(int Index);
	void __fastcall PaintHeader(HDC DC);
public:
	/* TacEditWnd.Create */ inline __fastcall virtual TacListViewWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacEditWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
public:
	/* TacScrollWnd.Destroy */ inline __fastcall virtual ~TacListViewWnd(void) { }
	
};


class DELPHICLASS TacGridWnd;
class PASCALIMPLEMENTATION TacGridWnd : public TacEditWnd
{
	typedef TacEditWnd inherited;
	
public:
	System::Uitypes::TColor EvenRowColor;
	System::Uitypes::TColor OddRowColor;
	System::Uitypes::TColor FixedColor;
	System::Uitypes::TColor FooterColor;
	System::Uitypes::TColor FooterCellColor;
	System::Uitypes::TColor TitleFontColor;
	System::Uitypes::TColor TitleColor;
	System::Uitypes::TColor IndColor;
	System::Uitypes::TColor SelectionColor;
	System::Uitypes::TColor SelectionTextColor;
	System::Uitypes::TColor GridLineColor;
	System::Uitypes::TColor GridFixedLineColor;
	System::Uitypes::TColor FixedGradientFrom;
	System::Uitypes::TColor FixedGradientTo;
	System::Uitypes::TColor FixedGradientMirrorFrom;
	System::Uitypes::TColor FixedGradientMirrorTo;
	Vcl::Grids::TGridDrawingStyle DrawingStyle;
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall SaveStdParams(void);
	virtual void __fastcall SetSkinParams(void);
	virtual void __fastcall RestoreStdParams(void);
public:
	/* TacEditWnd.Create */ inline __fastcall virtual TacGridWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacEditWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
public:
	/* TacScrollWnd.Destroy */ inline __fastcall virtual ~TacGridWnd(void) { }
	
};


class DELPHICLASS TacGridEhWnd;
class PASCALIMPLEMENTATION TacGridEhWnd : public TacGridWnd
{
	typedef TacGridWnd inherited;
	
public:
	bool Fixed3D;
	System::Uitypes::TColor BrightColor;
	System::Uitypes::TColor DataHorzColor;
	System::Uitypes::TColor DataVertColor;
	System::Uitypes::TColor DarkColor;
	System::Uitypes::TColor RowDetailColor;
	int IndHorzLines;
	int IndVertLines;
	int InfFillStyle;
	int TitleHorzLines;
	int TitleFillStyle;
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall SaveStdParams(void);
	virtual void __fastcall SetSkinParams(void);
	virtual void __fastcall RestoreStdParams(void);
public:
	/* TacEditWnd.Create */ inline __fastcall virtual TacGridEhWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacGridWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
public:
	/* TacScrollWnd.Destroy */ inline __fastcall virtual ~TacGridEhWnd(void) { }
	
};


class DELPHICLASS TacTreeViewWnd;
class PASCALIMPLEMENTATION TacTreeViewWnd : public TacEditWnd
{
	typedef TacEditWnd inherited;
	
public:
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall SetSkinParams(void);
	virtual void __fastcall RestoreStdParams(void);
	__fastcall virtual ~TacTreeViewWnd(void);
public:
	/* TacEditWnd.Create */ inline __fastcall virtual TacTreeViewWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacEditWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
};


class DELPHICLASS TacComboBoxWnd;
class PASCALIMPLEMENTATION TacComboBoxWnd : public TacEditWnd
{
	typedef TacEditWnd inherited;
	
public:
	HWND FListHandle;
	Scommondata::TsCommonData* LBSkinData;
	TacComboListWnd* ListSW;
	bool LBoxOpening;
	bool __fastcall DroppedDown(void);
	int __fastcall ButtonHeight(void);
	virtual System::Types::TRect __fastcall ButtonRect(void);
	void __fastcall PaintButton(HDC DC);
	void __fastcall RepaintButton(void);
	void __fastcall PaintText(void);
	void __fastcall PrepareSimple(void);
	virtual void __fastcall AfterCreation(void);
	__fastcall virtual ~TacComboBoxWnd(void);
	void __fastcall Invalidate(void);
	bool __fastcall EasyComboBox(void);
	void __fastcall CNDrawItem(Winapi::Messages::TWMDrawItem &Message);
	void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State, HDC DC);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacEditWnd.Create */ inline __fastcall virtual TacComboBoxWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacEditWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
};


class DELPHICLASS TacVirtualTreeViewWnd;
class PASCALIMPLEMENTATION TacVirtualTreeViewWnd : public TacEditWnd
{
	typedef TacEditWnd inherited;
	
public:
	System::Uitypes::TColor FocusedSelectionBorderColor;
	System::Uitypes::TColor FocusedSelectionColor;
	System::Uitypes::TColor UnfocusedSelectionBorderColor;
	System::Uitypes::TColor UnfocusedSelectionColor;
	System::Uitypes::TColor SelectionTextColor;
	System::Uitypes::TColor HotColor;
	System::Uitypes::TColor CompressedTextColor;
	System::Uitypes::TColor FileTextColor;
	System::Uitypes::TColor FolderTextColor;
	bool OwnerDraw;
	System::Typinfo::TPropInfo *PropInfo;
	void __fastcall AdvancedHeaderDraw(System::Classes::TPersistent* Sender, THeaderPaintInfo &PaintInfo, const THeaderPaintElements Elements);
	void __fastcall HeaderDrawQueryElements(System::Classes::TPersistent* Sender, THeaderPaintInfo &PaintInfo, THeaderPaintElements &Elements);
	virtual void __fastcall SaveStdParams(void);
	virtual void __fastcall SetSkinParams(void);
	virtual void __fastcall RestoreStdParams(void);
	System::Types::TSize __fastcall GetBorderDimensions(void);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacEditWnd.Create */ inline __fastcall virtual TacVirtualTreeViewWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacEditWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
public:
	/* TacScrollWnd.Destroy */ inline __fastcall virtual ~TacVirtualTreeViewWnd(void) { }
	
};


class DELPHICLASS TacWWComboBoxWnd;
class PASCALIMPLEMENTATION TacWWComboBoxWnd : public TacComboBoxWnd
{
	typedef TacComboBoxWnd inherited;
	
private:
	Vcl::Stdctrls::TCustomListBox* ListBox;
	TacScrollWnd* ListBoxSW;
	Scommondata::TsScrollWndData* ListBoxSkinData;
	bool FShowButton;
	bool __fastcall GetShowButton(Vcl::Controls::TWinControl* aCtrl);
	
public:
	virtual System::Types::TRect __fastcall ButtonRect(void);
	virtual void __fastcall AfterCreation(void);
	__fastcall virtual ~TacWWComboBoxWnd(void);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacEditWnd.Create */ inline __fastcall virtual TacWWComboBoxWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacComboBoxWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
};


class DELPHICLASS TacTabControlWnd;
class PASCALIMPLEMENTATION TacTabControlWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	TacSpinWnd* BtnSW;
	int __fastcall TabCount(void);
	virtual System::Types::TRect __fastcall ClientRect(void);
	virtual System::Types::TRect __fastcall PageRect(void);
	System::Types::TRect __fastcall TabRect(const int Index);
	int __fastcall TabRow(int TabIndex);
	System::Types::TRect __fastcall TabsRect(void);
	Vcl::Comctrls::TTabPosition __fastcall TabPosition(void);
	Vcl::Comctrls::TTabStyle __fastcall Style(void);
	int __fastcall ActiveTabIndex(void);
	System::Types::TRect __fastcall SkinTabRect(int Index, bool Active);
	void __fastcall CheckUpDown(void);
	void __fastcall DrawSkinTabs(const Sconst::TCacheInfo &CI);
	void __fastcall DrawSkinTab(int Index, int State, Vcl::Graphics::TBitmap* Bmp, const System::Types::TPoint &OffsetPoint)/* overload */;
	void __fastcall DrawSkinTab(int Index, int State, HDC DC)/* overload */;
	void __fastcall AC_WMPaint(Winapi::Messages::TWMPaint &Message);
	virtual void __fastcall AfterCreation(void);
	__fastcall virtual ~TacTabControlWnd(void);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacTabControlWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
};


class DELPHICLASS TacPageWnd;
class PASCALIMPLEMENTATION TacPageWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	Vcl::Comctrls::TTabSheet* Page;
	Vcl::Comctrls::TTabPosition __fastcall TabPosition(void);
	void __fastcall PrepareCache(void);
	void __fastcall AC_WMEraseBKGnd(Winapi::Messages::TWMPaint &Message);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall AfterCreation(void);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacPageWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacPageWnd(void) { }
	
};


class DELPHICLASS TacPageControlWnd;
class PASCALIMPLEMENTATION TacPageControlWnd : public TacTabControlWnd
{
	typedef TacTabControlWnd inherited;
	
public:
	virtual System::Types::TRect __fastcall ClientRect(void);
	virtual System::Types::TRect __fastcall PageRect(void);
	void __fastcall InitPages(void);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall AfterCreation(void);
public:
	/* TacTabControlWnd.Destroy */ inline __fastcall virtual ~TacPageControlWnd(void) { }
	
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacPageControlWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacTabControlWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
};


class DELPHICLASS TacToolBarVCLWnd;
class PASCALIMPLEMENTATION TacToolBarVCLWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	Vcl::Comctrls::TToolBar* ToolBar;
	Vcl::Comctrls::TToolButton* DroppedButton;
	int HotButtonIndex;
	System::Types::TRect __fastcall DisplayRect(void);
	void __fastcall WMNCPaint(const HDC aDC = (HDC)(0x0));
	System::Types::TRect __fastcall GetButtonRect(int Index);
	virtual void __fastcall AfterCreation(void);
	void __fastcall PrepareCache(void);
	int __fastcall IndexByMouse(const System::Types::TPoint &MousePos);
	void __fastcall RepaintButton(int Index);
	void __fastcall OurAdvancedCustomDraw(Vcl::Comctrls::TToolBar* Sender, const System::Types::TRect &ARect, Vcl::Comctrls::TCustomDrawStage Stage, bool &DefaultDraw);
	void __fastcall OurAdvancedCustomDrawButton(Vcl::Comctrls::TToolBar* Sender, Vcl::Comctrls::TToolButton* Button, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage, Vcl::Comctrls::TTBCustomDrawFlags &Flags, bool &DefaultDraw);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacToolBarVCLWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacToolBarVCLWnd(void) { }
	
};


class DELPHICLASS TacStatusBarWnd;
class PASCALIMPLEMENTATION TacStatusBarWnd : public TacMainWnd
{
	typedef TacMainWnd inherited;
	
public:
	Vcl::Comctrls::TStatusBar* StatusBar;
	bool __fastcall SimplePanel(void);
	int __fastcall PartsCount(void);
	System::UnicodeString __fastcall PartText(const int Index);
	System::Types::TRect __fastcall PartRect(const int Index);
	virtual void __fastcall AfterCreation(void);
	void __fastcall PaintPanels(void);
	void __fastcall PaintGrip(void);
	void __fastcall DrawPanel(const int Index, const System::Types::TRect &Rect);
	void __fastcall InternalDrawPanel(const int Index, const System::Types::TRect &Rect);
	void __fastcall DoDrawText(const System::UnicodeString Text, System::Types::TRect &Rect, const int Flags);
	void __fastcall PrepareCache(void);
	void __fastcall WMPaint(const HDC aDC = (HDC)(0x0));
	void __fastcall WMNCPaint(const HDC aDC = (HDC)(0x0));
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacStatusBarWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const TacSkinParams &SkinParams, bool Repaint) : TacMainWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	/* TacMainWnd.Destroy */ inline __fastcall virtual ~TacStatusBarWnd(void) { }
	
};


typedef System::TMetaClass* TacScrollWndClass;

class DELPHICLASS TacWinControl;
class PASCALIMPLEMENTATION TacWinControl : public Vcl::Controls::TWinControl
{
	typedef Vcl::Controls::TWinControl inherited;
	
public:
	/* TWinControl.Create */ inline __fastcall virtual TacWinControl(System::Classes::TComponent* AOwner) : Vcl::Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TacWinControl(HWND ParentWindow) : Vcl::Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TacWinControl(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 SM_BTNSIZE = System::Int8(0x0);
static const System::Int8 SM_SCROLLWIDTH = System::Int8(0x1);
static const System::Int8 TopOffset = System::Int8(0x4);
static const System::Int8 BottomOffset = System::Int8(0x2);
static const System::Int8 LeftOffset = System::Int8(0x1);
static const System::Int8 RightOffset = System::Int8(0x1);
extern DELPHI_PACKAGE System::StaticArray<Sconst::TacSide, 4> acTabSides;
extern DELPHI_PACKAGE int nLastSBPos;
extern DELPHI_PACKAGE bool acDlgMode;
extern DELPHI_PACKAGE int acMinThumbSize;
extern DELPHI_PACKAGE void __stdcall (*Ac_UninitializeFlatSB)(HWND hWnd);
extern DELPHI_PACKAGE BOOL __stdcall (*Ac_InitializeFlatSB)(HWND hWnd);
extern DELPHI_PACKAGE void __fastcall AlphaBroadCastCheck(Vcl::Controls::TControl* const Control, const HWND Handle, void *Message);
extern DELPHI_PACKAGE void __fastcall InitCtrlData(HWND Wnd, HWND &ParentWnd, System::Types::TRect &WndRect, System::Types::TRect &ParentRect, System::Types::TSize &WndSize, System::Types::TPoint &WndPos);
extern DELPHI_PACKAGE void __fastcall RefreshScrolls(Scommondata::TsScrollWndData* SkinData, TacScrollWnd* &ListSW);
extern DELPHI_PACKAGE void __fastcall RefreshEditScrolls(Scommondata::TsScrollWndData* SkinData, TacScrollWnd* &ListSW);
extern DELPHI_PACKAGE void __fastcall RefreshTreeScrolls(Scommondata::TsScrollWndData* SkinData, TacScrollWnd* &ListSW);
extern DELPHI_PACKAGE void __fastcall UpdateScrolls(TacScrollWnd* const sw, const bool Repaint = false);
extern DELPHI_PACKAGE void __fastcall PrepareCache(Scommondata::TsCommonData* SkinData, HWND CtrlHandle = (HWND)(0x0), bool DlgMode = false);
extern DELPHI_PACKAGE void __fastcall UninitializeACScroll(HWND Handle, bool FreeSW, bool Repaint, TacScrollWnd* &ListSW);
extern DELPHI_PACKAGE void __fastcall InitControl(HWND Handle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager);
extern DELPHI_PACKAGE bool __fastcall Scrolls_SetStyle(HWND Handle, int wBar, int nStyle);
extern DELPHI_PACKAGE void __fastcall UninitializeACWnd(HWND Handle, bool FreeSW, bool Repaint, TacMainWnd* &ListSW);
extern DELPHI_PACKAGE int __fastcall GetScrollMetric(TacScrollBar* sBar, int metric, bool Btn = false);
extern DELPHI_PACKAGE void __fastcall ac_GetHScrollRect(TacScrollWnd* sw, HWND Handle, System::Types::TRect &R);
extern DELPHI_PACKAGE void __fastcall ac_GetVScrollRect(TacScrollWnd* sw, HWND Handle, System::Types::TRect &R);
extern DELPHI_PACKAGE void __fastcall ac_DrawScrollBtn(const System::Types::TRect &bRect, int State, Vcl::Graphics::TBitmap* Bmp, Scommondata::TsCommonData* cd, Sconst::TacSide Side);
extern DELPHI_PACKAGE void __fastcall ac_DrawSlider(const System::Types::TRect &bRect, int State, Vcl::Graphics::TBitmap* Bmp, Sskinmanager::TsSkinManager* sm, bool Vert);
extern DELPHI_PACKAGE NativeInt __fastcall ac_NCDraw(TacScrollWnd* sw, HWND Handle, int ThumbPos = 0xffffffff, HDC aDC = (HDC)(0x0));
extern DELPHI_PACKAGE System::Types::TRect __fastcall RotateRect0(TacScrollBar* const sb, System::Types::TRect &R);
extern DELPHI_PACKAGE void __fastcall SendScrollMessage(const HWND Handle, const int scrMsg, const int scrId, const int pos);
extern DELPHI_PACKAGE System::Types::TRect __fastcall BtnDrawRect(const System::Types::TRect &R, Scommondata::TsCommonData* cd, Sconst::TacSide Side);
}	/* namespace Acsbutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACSBUTILS)
using namespace Acsbutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcsbutilsHPP
