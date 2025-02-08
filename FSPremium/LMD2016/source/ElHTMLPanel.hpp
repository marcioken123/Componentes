// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElHTMLPanel.pas' rev: 31.00 (Windows)

#ifndef ElhtmlpanelHPP
#define ElhtmlpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <System.Types.hpp>
#include <LMDProcs.hpp>
#include <LMDTypes.hpp>
#include <LMDHTMLUnit.hpp>
#include <ElPanel.hpp>
#include <ElVCLUtils.hpp>
#include <ElHTMLContainer.hpp>
#include <System.UITypes.hpp>
#include <LMDGraph.hpp>
#include <ElImgFrm.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elhtmlpanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomElHTMLPanel;
class DELPHICLASS TElHTMLPanel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomElHTMLPanel : public Elpanel::TCustomElPanel
{
	typedef Elpanel::TCustomElPanel inherited;
	
private:
	Elhtmlcontainer::TElHTMLChangeLink* FChangeLink;
	bool FCheck;
	Elhtmlcontainer::TElHTMLContainer* FContainer;
	System::Uitypes::TCursor FCursor;
	int FIndex;
	System::Uitypes::TColor FLinkColor;
	Vcl::Menus::TPopupMenu* FLinkPopupMenu;
	System::Uitypes::TFontStyles FLinkStyle;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLImageNeededEvent FOnImageNeededEx;
	Lmdhtmlunit::TLMDHTMLVariableNeededEvent FOnVariableNeeded;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	Lmdhtmlunit::TLMDHTMLTagFoundEvent FOnTagFound;
	System::Types::TRect FTextRect;
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	void __fastcall DoCaptionChange(System::TObject* Sender);
	Lmdtypes::TLMDString __fastcall GetCaptionText(void);
	void __fastcall SetContainer(Elhtmlcontainer::TElHTMLContainer* aValue);
	HIDESBASE void __fastcall SetCursor(System::Uitypes::TCursor newValue);
	void __fastcall SetIndex(int aValue);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Winapi::Messages::TWMContextMenu &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Winapi::Messages::TWMMouse &Message);
	
protected:
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall DoLinkPopup(const System::Types::TPoint &MousePos);
	bool __fastcall LinkEmpty(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation operation);
	virtual void __fastcall SetCaption(Lmdtypes::TLMDString newValue);
	virtual void __fastcall SetLinkColor(System::Uitypes::TColor newValue);
	virtual void __fastcall SetLinkPopupMenu(Vcl::Menus::TPopupMenu* newValue);
	virtual void __fastcall SetLinkStyle(System::Uitypes::TFontStyles newValue);
	virtual void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	virtual void __fastcall TriggerImageNeededExEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TPicture* Image);
	void __fastcall TriggerVariableNeededEvent(System::TObject* Sender, const Lmdtypes::TLMDString aVar, Lmdtypes::TLMDString &aVal);
	void __fastcall TriggerTagFoundEvent(System::TObject* Sender, Lmdtypes::TLMDString &Tag, Lmdhtmlunit::TLMDHTMLItem* &Item, System::Classes::TStringList* &Params, bool aClosing, bool aSupported);
	virtual void __fastcall TriggerLinkClickEvent(Lmdtypes::TLMDString HRef);
	virtual void __fastcall TriggerPaintEvent(void);
	__property bool CheckContainerLinks = {read=FCheck, write=FCheck, default=1};
	__property Elhtmlcontainer::TElHTMLContainer* Container = {read=FContainer, write=SetContainer};
	__property int ContainerIndex = {read=FIndex, write=SetIndex, default=0};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=SetCursor, nodefault};
	__property System::Uitypes::TColor LinkColor = {read=FLinkColor, write=SetLinkColor, default=16711680};
	__property Vcl::Menus::TPopupMenu* LinkPopupMenu = {read=FLinkPopupMenu, write=SetLinkPopupMenu};
	__property System::Uitypes::TFontStyles LinkStyle = {read=FLinkStyle, write=SetLinkStyle, default=4};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TLMDHTMLImageNeededEvent OnHTMLImageNeededEx = {read=FOnImageNeededEx, write=FOnImageNeededEx};
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Lmdhtmlunit::TLMDHTMLVariableNeededEvent OnVariableNeeded = {read=FOnVariableNeeded, write=FOnVariableNeeded};
	__property Lmdhtmlunit::TLMDHTMLTagFoundEvent OnTagFound = {read=FOnTagFound, write=FOnTagFound};
	
public:
	__fastcall virtual TCustomElHTMLPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElHTMLPanel(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElHTMLPanel(HWND ParentWindow) : Elpanel::TCustomElPanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElHTMLPanel : public TCustomElHTMLPanel
{
	typedef TCustomElHTMLPanel inherited;
	
__published:
	__property WordWrap = {default=0};
	__property Align = {default=0};
	__property Alignment = {default=2};
	__property Anchors = {default=3};
	__property Background;
	__property BackgroundType = {default=2};
	__property BevelInner = {default=0};
	__property BevelKind = {default=0};
	__property BevelOuter = {default=2};
	__property BevelWidth = {default=1};
	__property BorderStyle = {default=0};
	__property BorderWidth = {default=0};
	__property BottomGrabHandle;
	__property Caption;
	__property CheckContainerLinks = {default=1};
	__property Color = {default=-16777201};
	__property Constraints;
	__property Container;
	__property ContainerIndex = {default=0};
	__property Cursor;
	__property DockOrientation;
	__property DockSite = {default=0};
	__property DoubleBuffered;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property GradientEndColor = {default=0};
	__property GradientStartColor = {default=0};
	__property GradientSteps = {default=16};
	__property ImageForm;
	__property Layout = {default=1};
	__property LeftGrabHandle;
	__property LinkColor = {default=16711680};
	__property LinkPopupMenu;
	__property LinkStyle = {default=4};
	__property Locked = {default=0};
	__property MouseCapture = {default=0};
	__property Movable = {default=0};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnImageNeeded;
	__property OnHTMLImageNeededEx;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnLinkClick;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMove;
	__property OnResize;
	__property OnVariableNeeded;
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentThemeMode = {default=1};
	__property PopupMenu;
	__property Resizable = {default=0};
	__property RightGrabHandle;
	__property ShowFocus = {default=0};
	__property ShowHint;
	__property SizeGrip = {default=0};
	__property TabStop = {default=0};
	__property TopGrabHandle;
	__property Transparent = {default=0};
	__property TransparentXPThemes = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Visible = {default=1};
public:
	/* TCustomElHTMLPanel.Create */ inline __fastcall virtual TElHTMLPanel(System::Classes::TComponent* AOwner) : TCustomElHTMLPanel(AOwner) { }
	/* TCustomElHTMLPanel.Destroy */ inline __fastcall virtual ~TElHTMLPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElHTMLPanel(HWND ParentWindow) : TCustomElHTMLPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elhtmlpanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELHTMLPANEL)
using namespace Elhtmlpanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElhtmlpanelHPP
