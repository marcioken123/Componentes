// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sScrollBox.pas' rev: 27.00 (Windows)

#ifndef SscrollboxHPP
#define SscrollboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <acSBUtils.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sscrollbox
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TsPaintEvent)(Vcl::Graphics::TBitmap* ControlBmp);

class DELPHICLASS TsScrollBox;
class PASCALIMPLEMENTATION TsScrollBox : public Vcl::Forms::TScrollingWinControl
{
	typedef Vcl::Forms::TScrollingWinControl inherited;
	
private:
	Scommondata::TsScrollWndData* FCommonData;
	TsPaintEvent FOnPaint;
	System::Classes::TNotifyEvent FOnBeforeScroll;
	System::Classes::TNotifyEvent FOnAfterScroll;
	Vcl::Controls::TControlCanvas* FCanvas;
	System::Classes::TNotifyEvent FOnMouseLeave;
	System::Classes::TNotifyEvent FOnMouseEnter;
	bool FAutoMouseWheel;
	Vcl::Graphics::TCanvas* __fastcall GetCanvas(void);
	void __fastcall SetBorderStyle(const Vcl::Forms::TBorderStyle Value);
	
protected:
	int acTrackPos;
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Winapi::Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMPaint &Message);
	MESSAGE void __fastcall WMPrint(Winapi::Messages::TWMPaint &Message);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Winapi::Messages::TMessage &Message);
	
public:
	Acsbutils::TacScrollWnd* ListSW;
	__fastcall virtual TsScrollBox(System::Classes::TComponent* AOwner);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	__fastcall virtual ~TsScrollBox(void);
	DYNAMIC bool __fastcall DoMouseWheel(System::Classes::TShiftState Shift, int WheelDelta, const System::Types::TPoint &MousePos);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Loaded(void);
	HIDESBASE void __fastcall ScrollBy(int DeltaX, int DeltaY);
	bool __fastcall PrepareCache(void);
	void __fastcall Paint(HDC aDC = (HDC)(0x0), bool SendUpdated = true);
	virtual void __fastcall PaintWindow(HDC DC);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
__published:
	__property TsPaintEvent OnPaint = {read=FOnPaint, write=FOnPaint};
	__property System::Classes::TNotifyEvent OnAfterScroll = {read=FOnAfterScroll, write=FOnAfterScroll};
	__property System::Classes::TNotifyEvent OnBeforeScroll = {read=FOnBeforeScroll, write=FOnBeforeScroll};
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property bool AutoMouseWheel = {read=FAutoMouseWheel, write=FAutoMouseWheel, default=0};
	__property AutoScroll = {default=1};
	__property BiDiMode;
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property Vcl::Graphics::TCanvas* Canvas = {read=GetCanvas};
	__property Constraints;
	__property DockSite = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Touch;
	__property Visible = {default=1};
	__property OnCanResize;
	__property OnClick;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnGetSiteInfo;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnUnDock;
	__property Scommondata::TsScrollWndData* SkinData = {read=FCommonData, write=FCommonData};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsScrollBox(HWND ParentWindow) : Vcl::Forms::TScrollingWinControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall SkinScrollInView(Vcl::Controls::TControl* AControl, TsScrollBox* ScrollBox);
}	/* namespace Sscrollbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SSCROLLBOX)
using namespace Sscrollbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SscrollboxHPP
