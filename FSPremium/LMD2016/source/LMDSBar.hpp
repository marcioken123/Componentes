// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSBar.pas' rev: 31.00 (Windows)

#ifndef LmdsbarHPP
#define LmdsbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDObject.hpp>
#include <LMDSpinButton.hpp>
#include <LMDClass.hpp>
#include <LMDCaret.hpp>
#include <LMDFillObject.hpp>
#include <LMDBevel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDCustomParentPanel.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDFaceController.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDScrollBarThumb;
class DELPHICLASS TLMDScrollBar;
class DELPHICLASS TLMDScrollBarObject;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDScrollBarThumb : public Lmdcustompanelfill::TLMDCustomPanelFill
{
	typedef Lmdcustompanelfill::TLMDCustomPanelFill inherited;
	
private:
	bool FMousePressed;
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	
protected:
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseExit(void);
	virtual void __fastcall MouseEnter(void);
	
public:
	void __fastcall CreateGripBmp(bool vertical);
	__fastcall virtual TLMDScrollBarThumb(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDScrollBarThumb(void);
	virtual void __fastcall Paint(void);
	__property Bevel;
	__property Color = {default=-16777201};
	__property Ctl3D;
	__property FillObject;
	__property Flat = {default=0};
	__property ParentCtl3D = {default=1};
	__property Visible = {default=1};
	__property Transparent = {default=0};
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDScrollBarThumb(HWND ParentWindow) : Lmdcustompanelfill::TLMDCustomPanelFill(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TLMDScrollBarKind : unsigned char { skVertical, skHorizontal };

enum DECLSPEC_DENUM TLMDThumbMode : unsigned char { tmFixed, tmAuto };

enum DECLSPEC_DENUM TLMDBackStyle : unsigned char { bsDefault, bsUser };

class PASCALIMPLEMENTATION TLMDScrollBar : public Lmdcustombevelpanel::TLMDCustomBevelPanel
{
	typedef Lmdcustombevelpanel::TLMDCustomBevelPanel inherited;
	
private:
	Lmdclass::TLMDTimer* FTimerId;
	int MX;
	int MY;
	int FMin;
	int FMax;
	int FSmall;
	int FLarge;
	int FThumbLength;
	int FButtonWidth;
	int FBarWidth;
	int FPosition;
	int FOldPosition;
	TLMDScrollBarKind FKind;
	Lmdfillobject::TLMDFillObject* FBack;
	TLMDThumbMode FThumbMode;
	TLMDBackStyle FBackStyle;
	Vcl::Stdctrls::TScrollEvent FOnScroll;
	System::Uitypes::TCursor FThumbCursor;
	Lmdbevel::TLMDBevel* FThumbBevel;
	bool FThumbFlat;
	bool FAllowMousePos;
	bool FCanBeFocused;
	Lmdcaret::TLMDCaret* FCaret;
	TLMDScrollBarThumb* FBtnS;
	Lmdspinbutton::TLMDSpinButton* FBtn1;
	Lmdspinbutton::TLMDSpinButton* FBtn2;
	System::Types::TRect FPaintRect;
	Vcl::Graphics::TBitmap* FB;
	bool FMoveThumb;
	System::Types::TPoint FMousePos;
	System::Uitypes::TColor FThumbColor;
	int FTrackLength;
	bool FUseGlobalTimer;
	bool FHideFocus;
	void __fastcall SetBack(Lmdfillobject::TLMDFillObject* aValue);
	void __fastcall SetKind(TLMDScrollBarKind aValue);
	void __fastcall SetInteger(int index, int aValue);
	void __fastcall SetCanBeFocused(bool aValue);
	HIDESBASE void __fastcall SetBoolean(bool aValue);
	void __fastcall SetThumbBevel(Lmdbevel::TLMDBevel* aValue);
	HIDESBASE void __fastcall SetColor(System::Uitypes::TColor aValue);
	void __fastcall SetBackStyle(TLMDBackStyle aValue);
	void __fastcall DoThumbMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall DoThumbMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall DoThumbMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMStyleChanged(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSIZE(Winapi::Messages::TWMSize &Message);
	void __fastcall DoTimerEvent(System::TObject* Sender);
	int __fastcall GetDelta(void);
	
protected:
	virtual void __fastcall DoThemeChanged(void);
	void __fastcall ExecuteEvent(System::Uitypes::TScrollCode event);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseExit(void);
	virtual Lmdfillobject::TLMDFillObject* __fastcall GetFillObject(void);
	void __fastcall SetButtons(void);
	void __fastcall RefreshBackground(void);
	virtual void __fastcall DrawThemeBevel(Lmdclass::TLMDThemeMode aTheme, Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect);
	void __fastcall DoInc(System::TObject* Sender);
	void __fastcall DoDec(System::TObject* Sender);
	void __fastcall DoSpinBtnMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall DoSpinBtnMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall CheckBounds(void);
	void __fastcall EnableTimer(void);
	void __fastcall RemoveTimer(void);
	
public:
	__fastcall virtual TLMDScrollBar(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDScrollBar(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CalcTrackLength(void);
	virtual void __fastcall CalcPaintRect(void);
	__property int Delta = {read=GetDelta, nodefault};
	__property Lmdcaret::TLMDCaret* Caret = {read=FCaret};
	__property bool CanBeFocused = {read=FCanBeFocused, write=SetCanBeFocused, nodefault};
	__property CtlXP = {default=1};
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property BackFX;
	__property FaceController;
	__property Bevel;
	__property Color = {default=-16777201};
	__property Flat = {default=0};
	__property Hint;
	__property ParentColor = {default=0};
	__property bool HideFocus = {read=FHideFocus, write=FHideFocus, default=0};
	__property int Max = {read=FMax, write=SetInteger, index=0, default=100};
	__property int Min = {read=FMin, write=SetInteger, index=1, default=0};
	__property int Position = {read=FPosition, write=SetInteger, index=2, default=0};
	__property int SmallChange = {read=FSmall, write=FSmall, default=1};
	__property int LargeChange = {read=FLarge, write=FLarge, default=10};
	__property int ThumbLength = {read=FThumbLength, write=SetInteger, index=4, default=16};
	__property int TrackLength = {read=FTrackLength, nodefault};
	__property int BarWidth = {read=FBarWidth, write=SetInteger, index=5, default=16};
	__property TLMDBackStyle BackStyle = {read=FBackStyle, write=SetBackStyle, default=0};
	__property TLMDThumbMode ThumbMode = {read=FThumbMode, write=FThumbMode, default=0};
	__property bool ThumbFlat = {read=FThumbFlat, write=SetBoolean, default=0};
	__property System::Uitypes::TColor ThumbColor = {read=FThumbColor, write=SetColor, default=-16777201};
	__property Lmdbevel::TLMDBevel* ThumbBevel = {read=FThumbBevel, write=SetThumbBevel};
	__property System::Uitypes::TCursor ThumbCursor = {read=FThumbCursor, write=FThumbCursor, default=0};
	__property TLMDScrollBarKind Kind = {read=FKind, write=SetKind, default=1};
	__property int ButtonWidth = {read=FButtonWidth, write=SetInteger, index=3, default=16};
	__property Lmdfillobject::TLMDFillObject* Back = {read=FBack, write=SetBack};
	__property bool AllowMousePos = {read=FAllowMousePos, write=FAllowMousePos, default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Ctl3D;
	__property ParentCtl3D = {default=1};
	__property Transparent = {default=0};
	__property Enabled = {default=1};
	__property Cursor = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property HelpContext = {default=0};
	__property ShowHint;
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property bool UseGlobalTimer = {read=FUseGlobalTimer, write=FUseGlobalTimer, default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Visible = {default=1};
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property OnMouseWheel;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnEndDrag;
	__property OnDragOver;
	__property OnStartDrag;
	__property OnDragDrop;
	__property OnAfterEnter;
	__property OnAfterExit;
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseUp;
	__property Vcl::Stdctrls::TScrollEvent OnScroll = {read=FOnScroll, write=FOnScroll};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDScrollBar(HWND ParentWindow) : Lmdcustombevelpanel::TLMDCustomBevelPanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDScrollBarObject : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	Lmdfillobject::TLMDFillObject* FBack;
	Lmdbevel::TLMDBevel* FBevel;
	bool FAllowMousePos;
	bool FTransparent;
	bool FCtl3D;
	bool FParentCtl3D;
	int FButtonWidth;
	int FLargeChange;
	int FSmallChange;
	System::Uitypes::TCursor FCursor;
	System::Uitypes::TColor FColor;
	System::Uitypes::TColor FThumbColor;
	TLMDBackStyle FBackStyle;
	int FBarWidth;
	void __fastcall SetBack(Lmdfillobject::TLMDFillObject* aValue);
	void __fastcall SetBevel(Lmdbevel::TLMDBevel* aValue);
	void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetInteger(int index, int aValue);
	void __fastcall SetColor(int index, System::Uitypes::TColor aColor);
	void __fastcall SetBarWidth(const int Value);
	
public:
	__fastcall virtual TLMDScrollBarObject(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDScrollBarObject(void);
	void __fastcall AssignToScrollBar(TLMDScrollBar* aValue);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Lmdfillobject::TLMDFillObject* Back = {read=FBack, write=SetBack};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, index=0, default=-16777201};
	__property System::Uitypes::TColor ThumbColor = {read=FThumbColor, write=SetColor, index=1, default=-16777201};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=FCursor, default=0};
	__property Lmdbevel::TLMDBevel* Bevel = {read=FBevel, write=SetBevel};
	__property int ButtonWidth = {read=FButtonWidth, write=SetInteger, index=0, default=16};
	__property int SmallChange = {read=FSmallChange, write=SetInteger, index=1, default=1};
	__property int LargeChange = {read=FLargeChange, write=SetInteger, index=2, default=10};
	__property bool Transparent = {read=FTransparent, write=SetBoolean, index=0, default=0};
	__property bool Ctl3D = {read=FCtl3D, write=SetBoolean, index=1, default=1};
	__property bool ParentCtl3D = {read=FParentCtl3D, write=SetBoolean, index=2, default=1};
	__property bool AllowMousePos = {read=FAllowMousePos, write=FAllowMousePos, index=3, default=1};
	__property TLMDBackStyle BackStyle = {read=FBackStyle, write=FBackStyle, default=0};
	__property int BarWidth = {read=FBarWidth, write=SetBarWidth, default=16};
	__property OnChange;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSBAR)
using namespace Lmdsbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsbarHPP
