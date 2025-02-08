// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElPanel.pas' rev: 31.00 (Windows)

#ifndef ElpanelHPP
#define ElpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <System.Types.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Winapi.UxTheme.hpp>
#include <Vcl.Themes.hpp>
#include <ElCGControl.hpp>
#include <ElXPThemedControl.hpp>
#include <ElImgFrm.hpp>
#include <ElStyleMan.hpp>
#include <ElVCLUtils.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDUtils.hpp>
#include <LMDTypes.hpp>
#include <intfLMDBase.hpp>
#include <LMDGraph.hpp>
#include <LMDProcs.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elpanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElPanelGrabHandle;
class DELPHICLASS TCustomElPanel;
class DELPHICLASS TElPanel;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElPanelGrabHandleKind : unsigned char { ghkNone, ghkMove, ghkResize, ghkMoveParent };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElPanelGrabHandle : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FEnabled;
	int FSize;
	TElPanelGrabHandleKind FKind;
	Lmdgraph::TLMDBevelStyle FBevelKind;
	TCustomElPanel* FOwner;
	bool FVisible;
	void __fastcall SetVisible(bool newValue);
	void __fastcall SetEnabled(bool newValue);
	void __fastcall SetSize(int newValue);
	void __fastcall SetBevelKind(Lmdgraph::TLMDBevelStyle newValue);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property int Size = {read=FSize, write=SetSize, default=0};
	__property TElPanelGrabHandleKind Kind = {read=FKind, write=FKind, default=0};
	__property Lmdgraph::TLMDBevelStyle BevelKind = {read=FBevelKind, write=SetBevelKind, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElPanelGrabHandle(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElPanelGrabHandle(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TCustomElPanel : public Vcl::Extctrls::TCustomPanel
{
	typedef Vcl::Extctrls::TCustomPanel inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	System::Types::TSize FSize;
	bool __fastcall GetUseXPThemes(void);
	void __fastcall SetParentThemeMode(const bool Value);
	
protected:
	bool FParentThemeMode;
	bool FThemeGlobalMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FWordWrap;
	bool FIsUpdated;
	System::Uitypes::TColor FBorderColorShadow;
	System::Uitypes::TColor FBorderColorDkShadow;
	System::Uitypes::TColor FBorderColorWindow;
	System::Uitypes::TColor FBorderColorHighlight;
	System::Uitypes::TColor FBorderColorFace;
	Elvclutils::TElFlatBorderType FBorderType;
	Lmdgraph::TLMDBorderSides FBorderSides;
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	Lmdgraph::TLMDBevelStyle FBevelInner;
	Lmdgraph::TLMDBevelStyle FBevelOuter;
	Vcl::Controls::TBevelWidth FBevelWidth;
	bool FOwnerDraw;
	bool FAlwaysPaintBackground;
	Vcl::Stdctrls::TTextLayout FLayout;
	System::Classes::TNotifyEvent FOnPaint;
	int FGradientSteps;
	System::Uitypes::TColor FGradientStartColor;
	System::Uitypes::TColor FGradientEndColor;
	Vcl::Graphics::TBitmap* FTmpBmp;
	bool FTransparent;
	Vcl::Graphics::TBitmap* FBackground;
	Lmdgraph::TLMDBackgroundType FBackgroundType;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	Elimgfrm::TElImageForm* FImgForm;
	HWND FSaveCapture;
	System::Classes::TNotifyEvent FOnMove;
	bool FResizable;
	bool FMovable;
	System::Types::TRect FSizeMoveRect;
	System::StaticArray<TElPanelGrabHandle*, 4> FGrabHandles;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::Classes::TNotifyEvent FOnMouseLeave;
	bool FMouseInControl;
	bool FPressed;
	bool FIntPaint;
	Lmdtypes::TLMDString FCaption;
	System::Byte FAlphaLevel;
	bool FTransparentXPThemes;
	bool FSizeGrip;
	System::Types::TRect SizeGripRect;
	System::Uitypes::TColor FBevelSpaceColor;
	bool FShowFocus;
	Lmdtypes::TLMDString FHint;
	Elstyleman::TElStyleMgrChangeLink* FStyleMgrLink;
	Elstyleman::TElStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	int FCreating;
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadUseXPThemes(System::Classes::TReader* Reader);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual Vcl::Themes::TThemedElement __fastcall GetThemedElement(void);
	void __fastcall SetWordWrap(bool Value);
	virtual void __fastcall SetBorderType(const Elvclutils::TElFlatBorderType Value);
	HIDESBASE void __fastcall SetBorderStyle(Vcl::Forms::TBorderStyle Value);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	void __fastcall SetBorderColorDkShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorFace(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorHighlight(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorWindow(System::Uitypes::TColor Value);
	void __fastcall SetBackground(Vcl::Graphics::TBitmap* newValue);
	void __fastcall ImageChange(System::TObject* Sender);
	void __fastcall ImageFormChange(System::TObject* Sender);
	virtual void __fastcall SetResizable(bool newValue);
	HIDESBASE void __fastcall SetBevelInner(Lmdgraph::TLMDBevelStyle Value);
	HIDESBASE void __fastcall SetBevelOuter(Lmdgraph::TLMDBevelStyle Value);
	HIDESBASE void __fastcall SetBevelWidth(Vcl::Controls::TBevelWidth Value);
	MESSAGE void __fastcall WMEnterSizeMove(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMExitSizeMove(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMMove(Winapi::Messages::TWMMove &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	void __fastcall RedoTmpBmp(void);
	void __fastcall SetGradientStartColor(System::Uitypes::TColor newValue);
	void __fastcall SetGradientEndColor(System::Uitypes::TColor newValue);
	void __fastcall SetGradientSteps(int newValue);
	void __fastcall SetLayout(Vcl::Stdctrls::TTextLayout newValue);
	void __fastcall SetOwnerDraw(bool newValue);
	TElPanelGrabHandle* __fastcall GetTopGrabHandle(void);
	void __fastcall SetTopGrabHandle(TElPanelGrabHandle* newValue);
	TElPanelGrabHandle* __fastcall GetRightGrabHandle(void);
	void __fastcall SetRightGrabHandle(TElPanelGrabHandle* newValue);
	TElPanelGrabHandle* __fastcall GetLeftGrabHandle(void);
	void __fastcall SetLeftGrabHandle(TElPanelGrabHandle* newValue);
	TElPanelGrabHandle* __fastcall GetBottomGrabHandle(void);
	void __fastcall SetBottomGrabHandle(TElPanelGrabHandle* newValue);
	void __fastcall SetAlwaysPaintBackground(bool Value);
	virtual void __fastcall NotifyChildsThatRepaint(bool AllChilds = false);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	void __fastcall StyleMgrChange(System::TObject* Sender);
	virtual void __fastcall UpdateStyle(void);
	virtual void __fastcall SetBackgroundType(Lmdgraph::TLMDBackgroundType newValue);
	virtual void __fastcall SetTransparent(bool newValue);
	virtual void __fastcall SetMovable(bool newValue);
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	virtual void __fastcall Paint(void);
	virtual void __fastcall TriggerMoveEvent(void);
	virtual void __fastcall TriggerPaintEvent(void);
	virtual void __fastcall SetCaption(Lmdtypes::TLMDString newValue);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Message);
	virtual void __fastcall AdjustClientRect(System::Types::TRect &Rect);
	TElPanelGrabHandle* __fastcall InGrabHandle(int X, int Y, const System::Types::TRect &Rect);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall DoMouseEnter(void);
	DYNAMIC void __fastcall DoMouseLeave(void);
	virtual Lmdtypes::TLMDString __fastcall GetCaption(void);
	void __fastcall SetAlphaLevel(System::Byte Value);
	MESSAGE void __fastcall ELThemeChanged(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DrawThemedBackground(const System::Types::TRect &ARect);
	virtual System::Types::TRect __fastcall GetBackgroundClientRect(void);
	virtual void __fastcall SetTransparentXPThemes(bool Value);
	void __fastcall SetSizeGrip(bool Value);
	virtual void __fastcall UpdateInterior(void);
	void __fastcall SetBevelSpaceColor(System::Uitypes::TColor Value);
	void __fastcall SetShowFocus(bool Value);
	virtual void __fastcall PaintWindow(HDC DC);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	void __fastcall BeginCreate(void);
	void __fastcall EndCreate(void);
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=0};
	__property bool AlwaysPaintBackground = {read=FAlwaysPaintBackground, write=SetAlwaysPaintBackground, default=0};
	__property Vcl::Stdctrls::TTextLayout Layout = {read=FLayout, write=SetLayout, default=1};
	__property bool OwnerDraw = {read=FOwnerDraw, write=SetOwnerDraw, default=0};
	__property Vcl::Graphics::TBitmap* Background = {read=FBackground, write=SetBackground};
	__property Lmdgraph::TLMDBackgroundType BackgroundType = {read=FBackgroundType, write=SetBackgroundType, default=2};
	__property bool Resizable = {read=FResizable, write=SetResizable, default=0};
	__property bool Movable = {read=FMovable, write=SetMovable, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Lmdtypes::TLMDString Caption = {read=GetCaption, write=SetCaption};
	__property System::Uitypes::TColor GradientStartColor = {read=FGradientStartColor, write=SetGradientStartColor, default=0};
	__property System::Uitypes::TColor GradientEndColor = {read=FGradientEndColor, write=SetGradientEndColor, default=0};
	__property int GradientSteps = {read=FGradientSteps, write=SetGradientSteps, default=16};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property TElPanelGrabHandle* TopGrabHandle = {read=GetTopGrabHandle, write=SetTopGrabHandle};
	__property TElPanelGrabHandle* RightGrabHandle = {read=GetRightGrabHandle, write=SetRightGrabHandle};
	__property TElPanelGrabHandle* LeftGrabHandle = {read=GetLeftGrabHandle, write=SetLeftGrabHandle};
	__property TElPanelGrabHandle* BottomGrabHandle = {read=GetBottomGrabHandle, write=SetBottomGrabHandle};
	__property System::Classes::TNotifyEvent OnMove = {read=FOnMove, write=FOnMove};
	__property System::Classes::TNotifyEvent OnPaint = {read=FOnPaint, write=FOnPaint};
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property System::Byte AlphaLevel = {read=FAlphaLevel, write=SetAlphaLevel, default=0};
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, nodefault};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property bool TransparentXPThemes = {read=FTransparentXPThemes, write=SetTransparentXPThemes, default=1};
	__property MouseCapture = {default=0};
	__property TabStop = {default=0};
	__property bool SizeGrip = {read=FSizeGrip, write=SetSizeGrip, default=0};
	__property Lmdgraph::TLMDBevelStyle BevelInner = {read=FBevelInner, write=SetBevelInner, default=0};
	__property Lmdgraph::TLMDBevelStyle BevelOuter = {read=FBevelOuter, write=SetBevelOuter, default=2};
	__property Vcl::Controls::TBevelWidth BevelWidth = {read=FBevelWidth, write=SetBevelWidth, default=1};
	__property System::Uitypes::TColor BevelSpaceColor = {read=FBevelSpaceColor, write=SetBevelSpaceColor, default=-16777201};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=0};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
	__property System::Uitypes::TColor BorderColorDkShadow = {read=FBorderColorDkShadow, write=SetBorderColorDkShadow, default=-16777195};
	__property System::Uitypes::TColor BorderColorFace = {read=FBorderColorFace, write=SetBorderColorFace, default=-16777201};
	__property System::Uitypes::TColor BorderColorShadow = {read=FBorderColorShadow, write=SetBorderColorShadow, default=-16777200};
	__property System::Uitypes::TColor BorderColorHighlight = {read=FBorderColorHighlight, write=SetBorderColorHighlight, default=-16777196};
	__property System::Uitypes::TColor BorderColorWindow = {read=FBorderColorWindow, write=SetBorderColorWindow, default=-16777211};
	__property Elvclutils::TElFlatBorderType BorderType = {read=FBorderType, write=SetBorderType, default=1};
	virtual void __fastcall RepaintRect(const System::Types::TRect &ARect);
	
public:
	__fastcall virtual TCustomElPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElPanel(void);
	bool __fastcall IsThemed(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property bool MouseInControl = {read=FMouseInControl, nodefault};
	__property Canvas;
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, nodefault};
	
__published:
	__property DoubleBuffered;
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property Elstyleman::TElStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElPanel(HWND ParentWindow) : Vcl::Extctrls::TCustomPanel(ParentWindow) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


class PASCALIMPLEMENTATION TElPanel : public TCustomElPanel
{
	typedef TCustomElPanel inherited;
	
__published:
	__property WordWrap = {default=0};
	__property BorderSides = {default=15};
	__property BorderColorDkShadow = {default=-16777195};
	__property BorderColorFace = {default=-16777201};
	__property BorderColorShadow = {default=-16777200};
	__property BorderColorHighlight = {default=-16777196};
	__property BorderColorWindow = {default=-16777211};
	__property BorderType = {default=1};
	__property AlphaLevel = {default=0};
	__property AlwaysPaintBackground = {default=0};
	__property Background;
	__property BackgroundType = {default=2};
	__property GradientEndColor = {default=0};
	__property GradientStartColor = {default=0};
	__property GradientSteps = {default=16};
	__property Alignment = {default=2};
	__property Layout = {default=1};
	__property OwnerDraw = {default=0};
	__property ImageForm;
	__property TopGrabHandle;
	__property RightGrabHandle;
	__property LeftGrabHandle;
	__property BottomGrabHandle;
	__property Resizable = {default=0};
	__property Movable = {default=0};
	__property OnMove;
	__property OnPaint;
	__property SizeGrip = {default=0};
	__property Align;
	__property AutoSize = {default=0};
	__property BevelInner = {default=0};
	__property BevelOuter = {default=2};
	__property BevelSpaceColor = {default=-16777201};
	__property BevelWidth = {default=1};
	__property BorderStyle = {default=0};
	__property BorderWidth = {default=0};
	__property TransparentXPThemes = {default=1};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Color = {default=-16777201};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Locked = {default=0};
	__property MouseCapture = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowFocus = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Transparent = {default=0};
	__property Visible = {default=1};
	__property Caption;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnStartDrag;
	__property OnDockOver;
	__property OnDockDrop;
	__property OnUnDock;
	__property OnEndDock;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockSite = {default=0};
	__property DockOrientation;
	__property BevelKind = {default=0};
	__property DoubleBuffered = {default=0};
	__property DragKind = {default=0};
	__property OnContextPopup;
public:
	/* TCustomElPanel.Create */ inline __fastcall virtual TElPanel(System::Classes::TComponent* AOwner) : TCustomElPanel(AOwner) { }
	/* TCustomElPanel.Destroy */ inline __fastcall virtual ~TElPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElPanel(HWND ParentWindow) : TCustomElPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elpanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELPANEL)
using namespace Elpanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElpanelHPP
