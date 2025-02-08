// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWndButtonShape.pas' rev: 31.00 (Windows)

#ifndef LmdwndbuttonshapeHPP
#define LmdwndbuttonshapeHPP

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
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDGlyph.hpp>
#include <LMDProcs.hpp>
#include <LMDRegion.hpp>
#include <LMDButtonBase.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDFXCaption.hpp>
#include <LMDButtonLayout.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDFillObject.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwndbuttonshape
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWndButtonShape;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDWndButtonFocus : unsigned char { bfNone, bfText, bfClient };

enum DECLSPEC_DENUM TLMDWndButtonOffsetDirection : unsigned char { wbOffsetUpLeft, wbOffsetDownRight };

enum DECLSPEC_DENUM TLMDWndButtonStyle : unsigned char { wbWin40, wbWin31, wbSimple };

class PASCALIMPLEMENTATION TLMDWndButtonShape : public Lmdcustompanelfill::TLMDCustomPanelFill
{
	typedef Lmdcustompanelfill::TLMDCustomPanelFill inherited;
	
private:
	Lmdregion::TLMDRegion* FRegion;
	Lmdfxcaption::TLMDFxCaption* FFontFX;
	Lmdbuttonlayout::TLMDButtonLayout* FButtonLayout;
	bool FEnterColorChange;
	bool FFocused;
	bool FPressed;
	bool FMultiLine;
	bool FRepeatedClick;
	Lmdclass::TLMDTimer* FTimerID;
	int FRepeatingDelay;
	int FRepeatingInterval;
	System::TObject* FGlyph;
	TLMDWndButtonStyle FStyle;
	System::Uitypes::TModalResult FModalResult;
	TLMDWndButtonFocus FFocusStyle;
	System::Uitypes::TColor FEnterColor;
	System::Types::TPoint FCaptionStart;
	Lmdregion::TLMDBorderDrawEvent FOnDrawBorder;
	bool FUseGlobalTimer;
	TLMDWndButtonOffsetDirection FOffsetDirection;
	void __fastcall SetRegion(Lmdregion::TLMDRegion* aValue);
	void __fastcall SetFontFX(Lmdfxcaption::TLMDFxCaption* aValue);
	HIDESBASE void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetInteger(int index, int aValue);
	void __fastcall SetNumGlyphs(Lmdglyph::TLMDNumGlyphs aValue);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetButtonLayout(Lmdbuttonlayout::TLMDButtonLayout* aValue);
	void __fastcall SetStyle(TLMDWndButtonStyle aValue);
	void __fastcall SetModalResult(System::Uitypes::TModalResult aValue);
	void __fastcall SetEnterColor(System::Uitypes::TColor aValue);
	void __fastcall SetCaptionStart(const System::Types::TPoint &aValue);
	void __fastcall SetOffsetDirection(TLMDWndButtonOffsetDirection Value);
	Lmdglyph::TLMDNumGlyphs __fastcall GetNumGlyphs(void);
	Vcl::Graphics::TBitmap* __fastcall GetGlyph(void);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Winapi::Messages::TWMNoParams &Message);
	void __fastcall DoTimer(System::TObject* Sender);
	void __fastcall DeActivateTimer(void);
	void __fastcall ReadPoint(System::Classes::TStream* Reader);
	void __fastcall WritePoint(System::Classes::TStream* Writer);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual bool __fastcall CheckOptimized(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall OffsetInnerRect(System::Types::TRect &ARect);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall RestoreBorderBack(void);
	DYNAMIC void __fastcall RestoreBorderFront(void);
	
public:
	__fastcall virtual TLMDWndButtonShape(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDWndButtonShape(void);
	__property bool Pressed = {read=FPressed, nodefault};
	__property System::Types::TPoint CaptionStart = {read=FCaptionStart, write=SetCaptionStart};
	
__published:
	__property About = {default=0};
	__property Lmdbuttonlayout::TLMDButtonLayout* ButtonLayout = {read=FButtonLayout, write=SetButtonLayout};
	__property Caption = {default=0};
	__property Color = {default=-16777201};
	__property Cursor = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property System::Uitypes::TColor EnterColor = {read=FEnterColor, write=SetEnterColor, default=-16777207};
	__property bool EnterColorChange = {read=FEnterColorChange, write=SetBoolean, index=2, default=0};
	__property FillObject;
	__property Flat = {default=0};
	__property Font;
	__property Lmdfxcaption::TLMDFxCaption* FontFX = {read=FFontFX, write=SetFontFX};
	__property Vcl::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property System::Uitypes::TModalResult ModalResult = {read=FModalResult, write=SetModalResult, default=0};
	__property bool MultiLine = {read=FMultiLine, write=SetBoolean, index=0, default=1};
	__property Lmdglyph::TLMDNumGlyphs NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, nodefault};
	__property TLMDWndButtonOffsetDirection OffsetDirection = {read=FOffsetDirection, write=SetOffsetDirection, default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property Lmdregion::TLMDRegion* Region = {read=FRegion, write=SetRegion};
	__property bool RepeatedClick = {read=FRepeatedClick, write=SetBoolean, index=1, default=0};
	__property int RepeatingInterval = {read=FRepeatingInterval, write=SetInteger, index=1, default=10};
	__property int RepeatingDelay = {read=FRepeatingDelay, write=SetInteger, index=2, default=500};
	__property ShowHint;
	__property TLMDWndButtonStyle Style = {read=FStyle, write=SetStyle, default=2};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Transparent = {default=0};
	__property bool UseGlobalTimer = {read=FUseGlobalTimer, write=FUseGlobalTimer, default=0};
	__property Visible = {default=1};
	__property Lmdregion::TLMDBorderDrawEvent OnDrawBorder = {read=FOnDrawBorder, write=FOnDrawBorder};
	__property OnClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnContextPopup;
	__property OnMouseActivate;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDWndButtonShape(HWND ParentWindow) : Lmdcustompanelfill::TLMDCustomPanelFill(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdwndbuttonshape */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWNDBUTTONSHAPE)
using namespace Lmdwndbuttonshape;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwndbuttonshapeHPP
