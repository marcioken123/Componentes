// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDckSite.pas' rev: 31.00 (Windows)

#ifndef LmddcksiteHPP
#define LmddcksiteHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Consts.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>
#include <System.RTLConsts.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.GraphUtil.hpp>
#include <Vcl.Themes.hpp>
#include <Vcl.Styles.hpp>
#include <intfLMDBase.hpp>
#include <LMDUnicode.hpp>
#include <LMDTypes.hpp>
#include <LMDXML.hpp>
#include <LMDDckClass.hpp>
#include <LMDDckCst.hpp>
#include <LMDDckStyles.hpp>
#include <LMDDckStyleElems.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------
struct TLMDDockPanelBtn;
struct TAutoHideTab;

namespace Lmddcksite
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDDockManager;
class DELPHICLASS TLMDDragObject;
class DELPHICLASS TLMDFloatingForm;
class DELPHICLASS TLMDDockPanel;
struct TLMDZoneSplitterInfo;
struct TLMDZoneTabInfo;
struct TLMDTabbedDocsInfo;
struct TLMDDockSiteHitTest;
class DELPHICLASS TLMDDockZone;
struct TLMDDragTabInfo;
class DELPHICLASS TLMDDockZoneTree;
struct TLMDDragInfo;
struct TAutoHideTab;
class DELPHICLASS TLMDDockSite;
class DELPHICLASS TLMDDockManager;
//-- type declarations -------------------------------------------------------
typedef Vcl::Controls::TAlign TAlignEx;

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDDockManager : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDDockManager(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDDockManager(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDDockManager(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDDockManager(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDDockManager(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDDockManager(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDDockManager(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDDockManager(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDDockManager(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDDockManager(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDDockManager(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDDockManager(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDDockManager(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDDragObject : public Vcl::Controls::TDragDockObjectEx
{
	typedef Vcl::Controls::TDragDockObjectEx inherited;
	
private:
	Vcl::Controls::TWinControl* FDockingRect;
	bool FAccepted;
	bool FAcceptedExt;
	bool FInited;
	int FXOffset;
	int FYOffset;
	int FRWidth;
	int FRHeight;
	bool FTabInRect;
	TLMDFloatingForm* FDragForm;
	bool FDragContent;
	bool FAnimateRect;
	System::Uitypes::TColor FBorderColor;
	System::Uitypes::TColor FBackColor;
	void __fastcall Init(void);
	void __fastcall UpdateDragFormPos(const System::Types::TPoint &P);
	TLMDDockSite* __fastcall ControlSite(void);
	
protected:
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Msg);
	virtual System::Uitypes::TCursor __fastcall GetDragCursor(bool Accepted, int X, int Y);
	virtual void __fastcall AdjustDockRect(const System::Types::TRect &ARect);
	virtual void __fastcall DrawDragDockImage(void);
	virtual void __fastcall EraseDragDockImage(void);
	virtual void __fastcall EndDrag(System::TObject* Target, int X, int Y);
	
public:
	__fastcall virtual TLMDDragObject(Vcl::Controls::TControl* AControl);
	__fastcall virtual ~TLMDDragObject(void);
	__property bool TabInRect = {read=FTabInRect, write=FTabInRect, nodefault};
	__property bool DragContent = {read=FDragContent, write=FDragContent, nodefault};
	__property bool AnimateRect = {read=FAnimateRect, write=FAnimateRect, nodefault};
	__property System::Uitypes::TColor BackColor = {read=FBackColor, write=FBackColor, nodefault};
	__property System::Uitypes::TColor BorderColor = {read=FBorderColor, write=FBorderColor, nodefault};
};


class PASCALIMPLEMENTATION TLMDFloatingForm : public Vcl::Forms::TCustomForm
{
	typedef Vcl::Forms::TCustomForm inherited;
	
	
private:
	class DELPHICLASS TFormStyleHack;
	#pragma pack(push,4)
	class PASCALIMPLEMENTATION TFormStyleHack : public Vcl::Themes::TMouseTrackControlStyleHook
	{
		typedef Vcl::Themes::TMouseTrackControlStyleHook inherited;
		
	protected:
		System::Types::TRect FCaptionRect;
		bool FChangeSizeCalled;
	public:
		/* TMouseTrackControlStyleHook.Create */ inline __fastcall virtual TFormStyleHack(Vcl::Controls::TWinControl* AControl) : Vcl::Themes::TMouseTrackControlStyleHook(AControl) { }
		/* TMouseTrackControlStyleHook.Destroy */ inline __fastcall virtual ~TFormStyleHack(void) { }
		
	};
	
	#pragma pack(pop)
	
	class DELPHICLASS TStyleHook;
	#pragma pack(push,4)
	class PASCALIMPLEMENTATION TStyleHook : public Vcl::Forms::TFormStyleHook
	{
		typedef Vcl::Forms::TFormStyleHook inherited;
		
	private:
		HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
		HIDESBASE MESSAGE void __fastcall WMWindowPosChanging(Winapi::Messages::TWMWindowPosMsg &Message);
	public:
		/* TFormStyleHook.Create */ inline __fastcall virtual TStyleHook(Vcl::Controls::TWinControl* AControl) : Vcl::Forms::TFormStyleHook(AControl) { }
		/* TFormStyleHook.Destroy */ inline __fastcall virtual ~TStyleHook(void) { }
		
	};
	
	#pragma pack(pop)
	
	enum DECLSPEC_DENUM _TLMDFloatingForm__1 : unsigned char { ffsDragging, ffsAccepted, ffsPopupPending, ffsActivatePending, ffsUpdatingBorder };
	
	
private:
	System::Set<_TLMDFloatingForm__1, _TLMDFloatingForm__1::ffsDragging, _TLMDFloatingForm__1::ffsUpdatingBorder> FState;
	TLMDDockSite* FSite;
	Lmddckstyleelems::TLMDFloatFormKind FKind;
	TLMDDockPanel* FSinglePanel;
	System::Types::TRect FHeader;
	Lmddckstyleelems::TLMDPanelBtnKinds FButtons;
	Lmddckstyleelems::TLMDButtonsData FButtonsData;
	System::StaticArray<System::TObject*, 7> FGlows;
	System::Types::TRect FContent;
	bool FRgnSet;
	System::Types::TPoint FDragStart;
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall WMActivate(Winapi::Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Winapi::Messages::TWMGetMinMaxInfo &Message);
	HIDESBASE MESSAGE void __fastcall WMMove(Winapi::Messages::TWMMove &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMNCLButtonDown(Winapi::Messages::TWMNCHitMessage &Message);
	MESSAGE void __fastcall WMNCRButtonDown(Winapi::Messages::TWMNCHitMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Winapi::Messages::TWMMouse &Message);
	MESSAGE void __fastcall WMNCLButtonDblClk(Winapi::Messages::TWMNCHitMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMCancelMode(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Message);
	MESSAGE void __fastcall WMNCMouseMove(Winapi::Messages::TWMNCHitMessage &Message);
	MESSAGE void __fastcall WMTimer(Winapi::Messages::TMessage &Message);
	bool __fastcall GetIsEmpty(void);
	bool __fastcall GetIsDragging(void);
	bool __fastcall GetIsAccepted(void);
	bool __fastcall GetIsTopmost(void);
	void __fastcall SiteNotification(void);
	bool __fastcall HasVisiblePanels(void);
	Lmddckstyleelems::TLMDPanelBtnKind __fastcall FindButtonAtPoint(const System::Types::TPoint &P);
	NativeInt __fastcall SysHitTest(const System::Types::TPoint &P);
	TLMDDockManager* __fastcall ChooseManager(void);
	Lmddckstyleelems::TLMDDockElems* __fastcall StyleElems(void);
	void __fastcall InitGlows(void);
	void __fastcall FreeGlows(void);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	DYNAMIC void __fastcall DoAddDockClient(Vcl::Controls::TControl* Client, const System::Types::TRect &ARect);
	virtual void __fastcall AdjustClientRect(System::Types::TRect &Rect);
	DYNAMIC void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	DYNAMIC void __fastcall DoClose(System::Uitypes::TCloseAction &Action);
	DYNAMIC void __fastcall DoShow(void);
	void __fastcall UpdateBorder(void);
	void __fastcall UpdateTracking(bool AMouseDown, bool AMouseUp);
	void __fastcall CancelTracking(void);
	void __fastcall AdjustWindowRgn(void);
	void __fastcall UpdateGlows(bool AForceRedraw = false);
	DYNAMIC void __fastcall VisibleChanging(void);
	
public:
	__fastcall virtual TLMDFloatingForm(System::Classes::TComponent* AOwner);
	__fastcall TLMDFloatingForm(System::Classes::TComponent* AOwner, TLMDDockManager* AManager);
	__fastcall virtual ~TLMDFloatingForm(void);
	virtual bool __fastcall CloseQuery(void);
	void __fastcall ActivateOnNextShow(void);
	void __fastcall SetDraggingMode(const bool ADragging, const bool AAccepted);
	__property TLMDDockSite* Site = {read=FSite};
	__property bool IsEmpty = {read=GetIsEmpty, nodefault};
	__property bool IsDragging = {read=GetIsDragging, nodefault};
	__property bool IsAccepted = {read=GetIsAccepted, nodefault};
	__property bool IsTopmost = {read=GetIsTopmost, nodefault};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDFloatingForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TCustomForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFloatingForm(HWND ParentWindow) : Vcl::Forms::TCustomForm(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TLMDDockPanelHdrImage : unsigned char { hiDefault, hiShow, hiHide };

enum DECLSPEC_DENUM TLMDDockClientKind : unsigned char { dkTool, dkDocument };

enum DECLSPEC_DENUM Lmddcksite__6 : unsigned char { psDesignDragPending, psDesignDrag, psBeginAutoDragCalled, psUpdatingColors, psUpdatingParentFont };

typedef System::Set<Lmddcksite__6, Lmddcksite__6::psDesignDragPending, Lmddcksite__6::psUpdatingParentFont> TLMDDockPanelState;

typedef System::Uitypes::TCloseAction TLMDockPanelCloseAction;

typedef void __fastcall (__closure *TLMDockPanelCloseQuery)(System::TObject* Sender, bool &CanClose);

typedef void __fastcall (__closure *TLMDockPanelClose)(System::TObject* Sender, TLMDockPanelCloseAction &CloseAction);

typedef void __fastcall (__closure *TLMDDockPanelClick)(System::TObject* Sender, bool &AHandled);

class PASCALIMPLEMENTATION TLMDDockPanel : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDDockPanelState FState;
	TLMDDockSite* FLoadingSite;
	TLMDDockSite* FSite;
	TLMDDockZone* FZone;
	Vcl::Controls::TControl* FClientControl;
	bool FLastCheckActive;
	System::Types::TPoint FDsgDragStart;
	Vcl::Controls::TWinControl* FDsgDragRect;
	bool FOnSiteShowing;
	Vcl::Controls::TAlign FSpltrSide;
	System::Types::TRect FSpltrArea;
	bool FHaveHeader;
	System::Types::TRect FHeaderArea;
	Lmddckstyleelems::TLMDButtonsData FButtonsData;
	System::Types::TRect FContent;
	Vcl::Imglist::TCustomImageList* FImages;
	Vcl::Imglist::TChangeLink* FImageChangeLink;
	System::Uitypes::TImageIndex FImageIndex;
	bool FShowHeader;
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	Lmddckstyleelems::TLMDPanelBtnKinds FButtons;
	TLMDDockPanelHdrImage FShowHeaderImage;
	Vcl::Menus::TPopupMenu* FHeaderMenu;
	Vcl::Controls::TContextPopupEvent FOnHeaderPopup;
	bool FPanelVisible;
	System::Classes::TNotifyEvent FOnShow;
	System::Classes::TNotifyEvent FOnHide;
	bool FDefaultColor;
	bool FDefaultFontColor;
	TLMDDockClientKind FClientKind;
	TLMDockPanelClose FOnClose;
	TLMDockPanelCloseQuery FOnCloseQuery;
	TLMDDockPanelClick FOnHeaderDblClick;
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Winapi::Messages::TWMSetCursor &Message);
	HIDESBASE MESSAGE void __fastcall WMCancelMode(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Winapi::Messages::TWMContextMenu &Message);
	MESSAGE void __fastcall WMTimer(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMFloat(Vcl::Controls::TCMFloat &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMRelease(Winapi::Messages::TMessage &Message);
	void __fastcall InternalSetLoadingSite(TLMDDockSite* const Value);
	void __fastcall InternalSetToSite(TLMDDockSite* const Value, System::TObject* ADockTask);
	void __fastcall InternalResetSite(void);
	Vcl::Controls::TControl* __fastcall GetDockClient(void);
	void __fastcall SetOnSiteShowing(const bool Value);
	void __fastcall UpdateVisible(void);
	Lmddckstyleelems::TLMDPanelBtnKind __fastcall FindButtonAtPoint(const System::Types::TPoint &P);
	void __fastcall UpdateTracking(bool AMouseDown, bool AMouseUp);
	void __fastcall CancelTracking(void);
	void __fastcall ImagesChange(System::TObject* Sender);
	bool __fastcall GetActive(void);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetImageIndex(const System::Uitypes::TImageIndex Value);
	void __fastcall SetPanelVisible(const bool Value);
	void __fastcall SetShowHeader(const bool Value);
	void __fastcall SetBorderStyle(const Vcl::Forms::TBorderStyle Value);
	void __fastcall SetButtons(const Lmddckstyleelems::TLMDPanelBtnKinds Value);
	void __fastcall SetShowHeaderImage(const TLMDDockPanelHdrImage Value);
	void __fastcall SetHeaderMenu(Vcl::Menus::TPopupMenu* const Value);
	void __fastcall SetClientKind(const TLMDDockClientKind Value);
	HIDESBASE bool __fastcall IsColorStored(void);
	void __fastcall SetDefaultColor(const bool Value);
	void __fastcall SetDefaultFontColor(const bool Value);
	void __fastcall UpdateColors(void);
	System::Uitypes::TColor __fastcall GetDefFontColor(void);
	bool __fastcall GetVisible(void);
	void __fastcall UpdateMouseCapture(void);
	void __fastcall AdjustDockSizes(void);
	bool __fastcall CanHeaderPopup(void);
	void __fastcall HeaderPopup(const System::Types::TPoint &AMousePos);
	void __fastcall ActiveChanged(void);
	void __fastcall InvalidateBorder(const System::Types::TRect &FOldContent);
	void __fastcall UpdateHook(bool AHook);
	Lmddckstyleelems::TLMDDockElems* __fastcall StyleElems(void);
	void __fastcall InternalClose(void);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateHandle(void);
	DYNAMIC bool __fastcall DesignWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	virtual void __fastcall AdjustClientRect(System::Types::TRect &Rect);
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &ARect);
	DYNAMIC void __fastcall AdjustSize(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC void __fastcall BeginAutoDrag(void);
	virtual bool __fastcall GetFloating(void);
	DYNAMIC void __fastcall DoStartDock(Vcl::Controls::TDragObject* &DragObject);
	virtual void __fastcall ShowControl(Vcl::Controls::TControl* AControl);
	virtual void __fastcall ConstrainedResize(int &MinWidth, int &MinHeight, int &MaxWidth, int &MaxHeight);
	virtual bool __fastcall DoHeaderPopup(const System::Types::TPoint &AMousePos);
	virtual bool __fastcall DoHeaderDblClick(void);
	virtual void __fastcall DoActiveChanged(void);
	virtual TLMDockPanelCloseAction __fastcall DoClose(void);
	__property bool OnSiteShowing = {read=FOnSiteShowing, write=SetOnSiteShowing, nodefault};
	
public:
	__fastcall virtual TLMDDockPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDockPanel(void);
	void __fastcall Release(void);
	void __fastcall UpdateDesignDrag(TLMDDockSite* ASite, bool AMouseDown, bool AMouseUp, bool AImmediate, bool AUseCapture, bool AUseCursor, const System::Types::TPoint &P);
	void __fastcall CancelDesignDrag(TLMDDockSite* ASite);
	DYNAMIC void __fastcall SetDesignVisible(bool Value);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	DYNAMIC void __fastcall Dock(Vcl::Controls::TWinControl* NewDockSite, const System::Types::TRect &ARect);
	void __fastcall UpdateLayout(void);
	void __fastcall Activate(bool AShowParentForm = true);
	void __fastcall Deactivate(void);
	virtual bool __fastcall CloseQuery(void);
	void __fastcall Close(void);
	__property bool Active = {read=GetActive, nodefault};
	__property TLMDDockSite* Site = {read=FSite};
	__property TLMDDockZone* Zone = {read=FZone};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property System::Uitypes::TImageIndex ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property TLMDDockClientKind ClientKind = {read=FClientKind, write=SetClientKind, default=0};
	__property bool PanelVisible = {read=FPanelVisible, write=SetPanelVisible, default=1};
	__property bool ShowHeader = {read=FShowHeader, write=SetShowHeader, default=1};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property Lmddckstyleelems::TLMDPanelBtnKinds Buttons = {read=FButtons, write=SetButtons, default=15};
	__property TLMDDockPanelHdrImage ShowHeaderImage = {read=FShowHeaderImage, write=SetShowHeaderImage, default=0};
	__property Vcl::Menus::TPopupMenu* HeaderMenu = {read=FHeaderMenu, write=SetHeaderMenu};
	__property Vcl::Controls::TContextPopupEvent OnHeaderPopup = {read=FOnHeaderPopup, write=FOnHeaderPopup};
	__property System::Classes::TNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
	__property System::Classes::TNotifyEvent OnHide = {read=FOnHide, write=FOnHide};
	__property Color = {stored=IsColorStored, default=-16777211};
	__property ParentColor = {default=0};
	__property bool DefaultColor = {read=FDefaultColor, write=SetDefaultColor, default=1};
	__property bool DefaultFontColor = {read=FDefaultFontColor, write=SetDefaultFontColor, default=1};
	__property BiDiMode;
	__property Enabled = {default=1};
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentBackground;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Left;
	__property Top;
	__property Width;
	__property Height;
	__property DragMode = {default=1};
	__property Caption = {default=0};
	__property bool Visible = {read=GetVisible, stored=false, nodefault};
	__property PopupMenu;
	__property TLMDockPanelCloseQuery OnCloseQuery = {read=FOnCloseQuery, write=FOnCloseQuery};
	__property TLMDockPanelClose OnClose = {read=FOnClose, write=FOnClose};
	__property TLMDDockPanelClick OnHeaderDblClick = {read=FOnHeaderDblClick, write=FOnHeaderDblClick};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnEndDock;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDock;
	__property OnAlignInsertBefore;
	__property OnAlignPosition;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDockPanel(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
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


enum DECLSPEC_DENUM TLMDZoneKind : unsigned char { zkPanel, zkHorz, zkVert, zkTabs };

typedef System::Set<TLMDZoneKind, TLMDZoneKind::zkPanel, TLMDZoneKind::zkTabs> TLMDZoneKinds;

enum DECLSPEC_DENUM TLMDZoneResizeKind : unsigned char { zrkProportional, zrkFixed, zrkSpace };

struct DECLSPEC_DRECORD TLMDZoneSplitterInfo
{
public:
	System::Types::TRect Bounds;
	TLMDDockZone* ZoneA;
	TLMDDockZone* ZoneB;
};


struct DECLSPEC_DRECORD TLMDZoneTabInfo
{
public:
	System::Types::TRect Bounds;
	System::Types::TRect CloseBtn;
	System::Types::TRect Spacer;
	TLMDDockZone* Zone;
};


struct DECLSPEC_DRECORD TLMDTabbedDocsInfo
{
public:
	TLMDDockZone* MainZone;
	Lmddckstyleelems::TLMDActiveAreas AreasMask;
};


enum DECLSPEC_DENUM TLMDDockSiteHitKind : unsigned char { hkNone, hkZone, hkSplitter };

enum DECLSPEC_DENUM TLMDDockSiteHitZoneArea : unsigned char { hzaClient, hzaTabs };

struct DECLSPEC_DRECORD TLMDDockSiteHitTest
{
public:
	TLMDDockSiteHitKind Kind;
	TLMDDockZone* Zone;
	TLMDDockSiteHitZoneArea ZoneArea;
	int Index;
	Lmddckstyleelems::TLMDTabBtnKind TabBtn;
};


class PASCALIMPLEMENTATION TLMDDockZone : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<TLMDZoneSplitterInfo> _TLMDDockZone__1;
	
	typedef System::DynamicArray<TLMDZoneTabInfo> _TLMDDockZone__2;
	
	
public:
	TLMDDockZone* operator[](int AIndex) { return this->Zones[AIndex]; }
	
private:
	TLMDDockZoneTree* FTree;
	TLMDDockZone* FParent;
	TLMDZoneKind FKind;
	System::Classes::TList* FZones;
	TLMDDockPanel* FPanel;
	double FDSize;
	int FHeight;
	int FLeft;
	int FWidth;
	int FTop;
	TLMDDockZone* FSelectedPage;
	TLMDDockZone* FScrollToTab;
	bool FAutoHide;
	bool FInserting;
	bool FShowing;
	_TLMDDockZone__1 FSplitters;
	int FFirstTab;
	_TLMDDockZone__2 FTabs;
	System::Types::TRect FTabArea;
	System::Types::TRect FTabsClip;
	Lmddckstyleelems::TLMDTabBtnAreas FTabAreaBtns;
	bool FSeqWasHidden;
	Vcl::Controls::TAlign FAutoHideSide;
	bool FFixed;
	void __fastcall InsertZone(TLMDDockZone* AZone, int AIndex);
	void __fastcall RemoveZone(TLMDDockZone* AZone);
	TLMDZoneResizeKind __fastcall GetResizeKind(void);
	int __fastcall GetZoneCount(void);
	TLMDDockZone* __fastcall GetZones(int AIndex);
	int __fastcall GetSplitterCount(void);
	TLMDZoneSplitterInfo __fastcall GetSplitters(int AIndex);
	int __fastcall GetTabCount(void);
	TLMDZoneTabInfo __fastcall GetTabs(int AIndex);
	Lmddckstyleelems::TLMDZoneTabState __fastcall GetTabState(int AIndex);
	Lmddckstyleelems::TLMDTabBtnKind __fastcall GetHotTabBtn(int AIndex, /* out */ bool &ADown);
	void __fastcall RemoveTab(TLMDDockZone* ATab);
	System::Types::TRect __fastcall GetBounds(void);
	int __fastcall GetIndex(void);
	void __fastcall SetIndex(const int Value);
	void __fastcall SetResizeKind(const TLMDZoneResizeKind Value);
	void __fastcall SetAutoHide(const bool Value);
	void __fastcall SetSelectedPage(TLMDDockZone* const Value);
	void __fastcall SetFirstTab(const int Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall InternalSetPanel(TLMDDockPanel* const Value);
	void __fastcall InternalSetBounds(const System::Types::TRect &Value);
	void __fastcall InternalSetInserting(int AWidth, int AHeight);
	TLMDDockZone* __fastcall FindMainDocsZone(void);
	void __fastcall PanelUIStateChanged(TLMDDockPanel* APanel);
	
protected:
	void __fastcall CopyFrom(TLMDDockZone* ASource);
	void __fastcall UpdatePanelZn(void);
	void __fastcall UpdateSeqZn(System::TObject* ASeqHandler);
	void __fastcall UpdateTabsZn(void);
	TLMDDockZone* __fastcall UpdateTabArea(void);
	void __fastcall UpdateAutoHide(void);
	void __fastcall UpdateLayout(void);
	void __fastcall UpdateDockTracking(void);
	void __fastcall Paint(Vcl::Graphics::TCanvas* ACanvas);
	
public:
	__fastcall TLMDDockZone(TLMDDockZoneTree* ATree)/* overload */;
	__fastcall TLMDDockZone(TLMDDockZoneTree* ATree, TLMDDockPanel* APanel)/* overload */;
	__fastcall virtual ~TLMDDockZone(void);
	bool __fastcall IsEmpty(void);
	bool __fastcall IsEmptySpace(void);
	bool __fastcall IsAutoHidden(void);
	void __fastcall AutoHideClose(void);
	bool __fastcall ContainSpace(void);
	bool __fastcall TabbedDocsHost(void);
	bool __fastcall TabbedDocsInfo(/* out */ TLMDTabbedDocsInfo &AInfo);
	bool __fastcall ContainsVisibleContent(void);
	bool __fastcall ContainsPanel(TLMDDockPanel* APanel);
	Lmdtypes::TLMDString __fastcall Caption(void);
	bool __fastcall GetImageParams(/* out */ Vcl::Imglist::TCustomImageList* &AImages, /* out */ int &AImageIndex);
	bool __fastcall GetTabImageParams(TLMDDockZone* AChild, /* out */ Vcl::Imglist::TCustomImageList* &AImages, /* out */ int &AImageIndex);
	bool __fastcall GetTabPanel(TLMDDockZone* AChild, /* out */ TLMDDockPanel* &APanel);
	Lmdtypes::TLMDString __fastcall GetTabCaption(TLMDDockZone* AChild);
	int __fastcall GetBaseTabWidth(TLMDDockZone* AChild);
	Lmddckstyleelems::TLMDTabBtnKinds __fastcall GetTabButtons(TLMDDockZone* AChild);
	int __fastcall GetInsertingTabIndex(const System::Types::TPoint &P, Vcl::Controls::TControl* AClient);
	bool __fastcall IsTabInView(TLMDDockZone* AChild);
	void __fastcall ScrollToTab(TLMDDockZone* AChild);
	void __fastcall ClearZones(void);
	int __fastcall AddZone(TLMDDockZone* AZone)/* overload */;
	void __fastcall AddZone(TLMDDockZone* AZone, int AIndex)/* overload */;
	bool __fastcall HasPanelZones(bool AVisibleOnly);
	void __fastcall GetPanelZones(bool AVisibleOnly, System::Classes::TList* AResult);
	void __fastcall SetChildrenSizes(const int *ASizes, const int ASizes_High);
	__property TLMDDockZone* Parent = {read=FParent};
	__property int Index = {read=GetIndex, write=SetIndex, nodefault};
	__property TLMDZoneKind Kind = {read=FKind, nodefault};
	__property int ZoneCount = {read=GetZoneCount, nodefault};
	__property TLMDDockZone* Zones[int AIndex] = {read=GetZones/*, default*/};
	__property TLMDDockPanel* Panel = {read=FPanel};
	__property int SplitterCount = {read=GetSplitterCount, nodefault};
	__property TLMDZoneSplitterInfo Splitters[int AIndex] = {read=GetSplitters};
	__property int TabCount = {read=GetTabCount, nodefault};
	__property TLMDZoneTabInfo Tabs[int AIndex] = {read=GetTabs};
	__property TLMDDockZone* SelectedPage = {read=FSelectedPage, write=SetSelectedPage};
	__property int FirstTab = {read=FFirstTab, write=SetFirstTab, nodefault};
	__property double DSize = {read=FDSize};
	__property bool Inserting = {read=FInserting, nodefault};
	__property int Left = {read=FLeft, nodefault};
	__property int Top = {read=FTop, nodefault};
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property System::Types::TRect Bounds = {read=GetBounds};
	__property bool Showing = {read=FShowing, nodefault};
	__property Vcl::Controls::TAlign AutoHideSide = {read=FAutoHideSide, nodefault};
	__property bool AutoHide = {read=FAutoHide, write=SetAutoHide, nodefault};
	__property TLMDZoneResizeKind ResizeKind = {read=GetResizeKind, write=SetResizeKind, nodefault};
};


struct DECLSPEC_DRECORD TLMDDragTabInfo
{
public:
	int ZoneIndex;
	Vcl::Controls::TControl* Client;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDockZoneTree : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDDockSite* FSite;
	TLMDDockZone* FRoot;
	TLMDDockZone* FSpaceZone;
	System::Types::TRect FBorderBounds;
	System::StaticArray<System::Classes::TList*, 7> FAutoHideZones;
	TLMDDockZone* FDragTabZone;
	TLMDDragTabInfo FDragTabInfo;
	TLMDDockZone* FHotTabZone;
	int FHotTabIndex;
	Lmddckstyleelems::TLMDTabBtnKind FHotTabBtn;
	bool FHotTabBtnDown;
	System::TObject* FHorzHandler;
	System::TObject* FVertHandler;
	NativeUInt FDeferHandle;
	TLMDDockPanel* FActivatePanel;
	void __fastcall ZoneDestroying(TLMDDockZone* AZone);
	void __fastcall DoNormalizeZone(TLMDDockZone* AZone);
	void __fastcall RemoveFromAutoHideZones(TLMDDockZone* AZone);
	void __fastcall ClearAutoHideZones(void);
	void __fastcall CorrectDocZones(void);
	
public:
	__fastcall virtual TLMDDockZoneTree(TLMDDockSite* ASite);
	__fastcall virtual ~TLMDDockZoneTree(void);
	void __fastcall Clear(void);
	TLMDDockZone* __fastcall FindZoneByClient(Vcl::Controls::TControl* AClient);
	System::Types::TRect __fastcall GetInsertingRect(TLMDDockZone* AZone, Vcl::Controls::TAlign ADropAlign, Vcl::Controls::TControl* AClient);
	void __fastcall Paint(Vcl::Graphics::TCanvas* ACanvas);
	void __fastcall InsertPanel(TLMDDockPanel* APanel, System::TObject* ADockTask);
	void __fastcall RemovePanel(TLMDDockPanel* APanel);
	void __fastcall NormalizeZones(void);
	void __fastcall UpdateLayout(TLMDDockPanel* AActivate = (TLMDDockPanel*)(0x0));
	void __fastcall SetDragTab(TLMDDockZone* ATabZone, const TLMDDragTabInfo &ATabInfo, bool AInvalidate = true);
	void __fastcall ResetDragTab(bool AInvalidate = true);
	void __fastcall SetHotTab(TLMDDockZone* ATabZone, int ATabIndex, bool AInvalidate = true);
	void __fastcall ResetHotTab(bool AInvalidate = true);
	void __fastcall SetHotBtn(Lmddckstyleelems::TLMDTabBtnKind AHotBtn, bool AHotDown, bool AInvalidate = true);
	void __fastcall ResetTabBtn(bool AInvalidate = true);
	void __fastcall GetUnpinnedPanelZones(Vcl::Controls::TAlign ASide, bool AVisibleOnly, System::Classes::TList* AResult);
	__property TLMDDockZone* Root = {read=FRoot};
	__property TLMDDockZone* Space = {read=FSpaceZone};
	__property TLMDDockZone* DragTabZone = {read=FDragTabZone};
	__property TLMDDragTabInfo DragTabInfo = {read=FDragTabInfo};
};

#pragma pack(pop)

enum DECLSPEC_DENUM Lmddcksite__01 : unsigned char { dlmDockIn, dlmUndockFrom, dlmSplitterResize, dlmPanelAutoHide, dlmPanelClose };

typedef System::Set<Lmddcksite__01, Lmddcksite__01::dlmDockIn, Lmddcksite__01::dlmPanelClose> TLMDDockSiteLockMode;

struct DECLSPEC_DRECORD TLMDDragInfo
{
public:
	TLMDDockZone* Zone;
	Vcl::Controls::TAlign Align;
	int Index;
	System::Types::TRect Rect;
	bool TabInRect;
};


typedef Lmddckstyleelems::TLMDActiveArea TLMDHotSpotArea _DEPRECATED_ATTRIBUTE0 ;

typedef Lmddckstyleelems::TLMDActiveAreas TLMDHotSpotAreas _DEPRECATED_ATTRIBUTE0 ;

struct DECLSPEC_DRECORD TAutoHideTab
{
public:
	TLMDDockZone* PanelZone;
	System::Types::TRect Bounds;
	System::Types::TRect Spacer;
};


typedef System::DynamicArray<TAutoHideTab> TAutoHideTabs;

enum DECLSPEC_DENUM TLMDAutoHideState : unsigned char { ahsOpened, ahsClosed };

typedef void __fastcall (__closure *TLMDDockSiteOnCustomInsertQuery)(System::TObject* Sender, Vcl::Controls::TControl* AClient, TLMDDockZone* AZone, Vcl::Controls::TAlign AAlign, bool &AIsCustomInsert);

typedef void __fastcall (__closure *TLMDDockSiteOnCustomInsert)(System::TObject* Sender, Vcl::Controls::TControl* AClient, TLMDDockZone* AZone, Vcl::Controls::TAlign AAlign);

typedef void __fastcall (__closure *TLMDDockSiteOnDockOver)(System::TObject* Sender, Vcl::Controls::TDragDockObject* Source, TLMDDockZone* AZone, Vcl::Controls::TAlign AAlign, bool &Accept);

typedef void __fastcall (__closure *TLMDDockSiteOnDockDrop)(System::TObject* Sender, Vcl::Controls::TDragDockObject* Source, TLMDDockZone* AZone, Vcl::Controls::TAlign AAlign);

typedef void __fastcall (__closure *TLMDDockSiteOnUpdateHotSpots)(System::TObject* Sender, TLMDDockZone* AZone, Lmddckstyleelems::TLMDActiveAreas &EnabledAreas);

typedef void __fastcall (__closure *TLMDDockSiteOnAutoHide)(System::TObject* Sender, Vcl::Controls::TControl* AClient, TLMDAutoHideState AState);

enum DECLSPEC_DENUM Lmddcksite__11 : unsigned char { dssUpdatingPanels, dssRemovingUndocked, dssSplitSizing, dssTabBtnDown, dssLoadingLayout, dssCustomInsert, dssNoAlignControls };

typedef System::Set<Lmddcksite__11, Lmddcksite__11::dssUpdatingPanels, Lmddcksite__11::dssNoAlignControls> TLMDDockSiteState;

class PASCALIMPLEMENTATION TLMDDockSite : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDDockSite* FNext;
	TLMDDockSiteState FState;
	TLMDDockSiteLockMode FLockMode;
	TLMDDockManager* FManager;
	System::Classes::TReader* FFixupReader;
	System::Classes::TList* FLoadingPanels;
	Lmdxml::_di_ILMDXmlDocument FReadedLayout;
	System::Classes::TList* FPanels;
	bool FInDragMsg;
	System::TObject* FDockTask;
	TLMDDockPanel* FUndockPanel;
	System::StaticArray<System::TObject*, 5> FHotspots;
	bool FSplitterAreas;
	bool FZoneTabAreas;
	System::StaticArray<Vcl::Controls::TControl*, 7> FAutoHideSides;
	TLMDDockZoneTree* FZoneTree;
	System::TObject* FSplitSizer;
	System::TObject* FShifter;
	TLMDDockPanel* FShiftingPanel;
	Vcl::Controls::TAlign FShiftingSide;
	TLMDAutoHideState FShiftingEvent;
	bool FLoadDesignLayout;
	bool FUseSpace;
	Vcl::Menus::TPopupMenu* FTabsMenu;
	TLMDDockSiteOnCustomInsertQuery FOnCustomInsertQuery;
	TLMDDockSiteOnCustomInsert FOnCustomInsert;
	TLMDDockSiteOnDockOver FOnDockOver;
	TLMDDockSiteOnDockDrop FOnDockDrop;
	System::Classes::TNotifyEvent FOnChange;
	TLMDDockSiteOnUpdateHotSpots FOnUpdateHotSpots;
	TLMDDockSiteOnAutoHide FOnAutoHide;
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Winapi::Messages::TWMSetCursor &Message);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Winapi::Messages::TWMContextMenu &Message);
	HIDESBASE MESSAGE void __fastcall WMCancelMode(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDrag(Vcl::Controls::TCMDrag &Message);
	MESSAGE void __fastcall CMDockNotification(Vcl::Controls::TCMDockNotification &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNKeyDown(Winapi::Messages::TWMKey &Message);
	MESSAGE void __fastcall CMStyleChanged(Winapi::Messages::TMessage &Message);
	void __fastcall ZoneDestroying(TLMDDockZone* AZone);
	void __fastcall ClearLoadingPanels(void);
	void __fastcall InsertOrUpdatePanel(TLMDDockPanel* APanel, System::TObject* ADockTask);
	void __fastcall RemovePanel(TLMDDockPanel* APanel);
	void __fastcall PanelUIStateChanged(TLMDDockPanel* APanel);
	void __fastcall DestroyPanels(void);
	void __fastcall InternalDockControl(Vcl::Controls::TControl* AControl, TLMDDockZone* ADropOnZone, Vcl::Controls::TAlign AAlign, int AIndex, bool ASelectPage, bool AExactSet = false);
	System::TObject* __fastcall FindHotspot(const System::Types::TPoint &P);
	TLMDDragInfo __fastcall GetDragInfo(const System::Types::TPoint &P, Vcl::Controls::TControl* AClient, Vcl::Controls::TDragDockObject* ASource = (Vcl::Controls::TDragDockObject*)(0x0));
	int __fastcall GetPanelCount(void);
	TLMDDockPanel* __fastcall GetPanels(int AIndex);
	TLMDDockZone* __fastcall GetRootZone(void);
	TLMDDockZone* __fastcall GetSpaceZone(void);
	System::TObject* __fastcall DockTaskFromDropInfo(Vcl::Controls::TControl* AClient, int AWidth, int AHeight, const TLMDDragInfo &ADropInfo, Vcl::Controls::TDragDockObject* AManualDockSrc = (Vcl::Controls::TDragDockObject*)(0x0));
	TLMDDragInfo __fastcall UpdateDockTracking(const System::Types::TPoint &P, Vcl::Controls::TControl* AClient, Vcl::Controls::TDragDockObject* ASource = (Vcl::Controls::TDragDockObject*)(0x0));
	void __fastcall EndDockTracking(bool AInvalidate = true);
	void __fastcall UpdateTracking(void);
	void __fastcall CancelTracking(void);
	void __fastcall DesignDrag(TLMDDockPanel* APanel, Vcl::Controls::TDragMessage ADragMsg, const System::Types::TPoint &P, System::Types::TRect &R, bool &AShowRect, bool &ATabInRect);
	void __fastcall ZoneSizingFinishProc(bool AAccept, System::TObject* AData, int AData2, const System::Types::TRect &ASpltBounds);
	void __fastcall PanelSizingFinishProc(bool AAccept, System::TObject* AData, int AData2, const System::Types::TRect &ASpltBounds);
	void __fastcall BeginSplitterSizing(TLMDDockZone* AZone, int ASplIndex, const System::Types::TPoint &P)/* overload */;
	void __fastcall BeginSplitterSizing(TLMDDockPanel* APanel, const System::Types::TPoint &P)/* overload */;
	void __fastcall UpdateSplitterSizing(const System::Types::TPoint &P);
	void __fastcall EndSplitterSizing(bool AAccept);
	void __fastcall SetShifingPanel(TLMDDockPanel* APanel, Vcl::Controls::TAlign ASide, bool AOpen, bool AActivate, bool AImmediateInvert = true);
	void __fastcall RaiseShiftingEvent(TLMDDockPanel* APanel, TLMDAutoHideState AState);
	void __fastcall BeginLoading(void);
	void __fastcall EndLoading(void);
	void __fastcall IdToCompProc(const Lmdtypes::TLMDString AId, /* out */ System::Classes::TComponent* &AComp);
	void __fastcall CompToIdProc(System::Classes::TComponent* AComp, /* out */ Lmdtypes::TLMDString &AId);
	void __fastcall ReferenceIdProc(Lmdtypes::TLMDString &AId);
	void __fastcall ReadLayout(System::Classes::TStream* Stream);
	void __fastcall WriteLayout(System::Classes::TStream* Stream);
	void __fastcall FixupReadedIds(System::Classes::TReader* AReader);
	void __fastcall FreeReadedLayout(bool ADockLoadingPanels);
	void __fastcall ApplyReadedLayout(void);
	bool __fastcall TryCustomInsert(Vcl::Controls::TControl* AClient, TLMDDockZone* AZone, Vcl::Controls::TAlign AAlign);
	void __fastcall SetUseSpace(const bool Value);
	void __fastcall UpdateUndockSizes(void);
	bool __fastcall DeactivateActiveChild(TLMDDockPanel* const *ACheckOnly, const int ACheckOnly_High, TLMDDockPanel* const *AExclude, const int AExclude_High);
	void __fastcall ManagerChanged(void);
	TLMDDockClientKind __fastcall GetClientKind(Vcl::Controls::TControl* AClient);
	void __fastcall SetLockMode(const TLMDDockSiteLockMode Value);
	void __fastcall SetManager(TLMDDockManager* const Value);
	Lmddckstyleelems::TLMDDockElems* __fastcall StyleElems(void);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Updated(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateHandle(void);
	DYNAMIC bool __fastcall DesignWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &ARect);
	DYNAMIC bool __fastcall IsQualifyingSite(Vcl::Controls::TControl* const Client);
	DYNAMIC void __fastcall GetSiteInfo(Vcl::Controls::TControl* Client, System::Types::TRect &InfluenceRect, const System::Types::TPoint &MousePos, bool &CanDock);
	DYNAMIC void __fastcall DoAddDockClient(Vcl::Controls::TControl* Client, const System::Types::TRect &ARect);
	DYNAMIC void __fastcall DockOver(Vcl::Controls::TDragDockObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	DYNAMIC bool __fastcall DoUnDock(Vcl::Controls::TWinControl* NewTarget, Vcl::Controls::TControl* Client);
	DYNAMIC void __fastcall DoRemoveDockClient(Vcl::Controls::TControl* Client);
	virtual void __fastcall ShowControl(Vcl::Controls::TControl* AControl);
	virtual void __fastcall GetClientImageParams(Vcl::Controls::TControl* AClient, /* out */ Vcl::Imglist::TCustomImageList* &AImages, /* out */ int &AImageIndex);
	virtual void __fastcall DoChange(void);
	HIDESBASE virtual bool __fastcall DoDockOver(Vcl::Controls::TDragDockObject* Source, TLMDDockZone* AZone, Vcl::Controls::TAlign AAlign);
	virtual void __fastcall DoDockDrop(Vcl::Controls::TDragDockObject* Source, TLMDDockZone* AZone, Vcl::Controls::TAlign AAlign);
	virtual bool __fastcall DoCustomInsertQuery(Vcl::Controls::TControl* AClient, TLMDDockZone* AZone, Vcl::Controls::TAlign AAlign);
	virtual void __fastcall DoCustomInsert(Vcl::Controls::TControl* AClient, TLMDDockZone* AZone, Vcl::Controls::TAlign AAlign);
	virtual void __fastcall DoUpdateHotSpots(Vcl::Controls::TControl* AClient, TLMDDockZone* AZone, Lmddckstyleelems::TLMDActiveAreas &EnabledAreas);
	virtual void __fastcall DoAutoHide(Vcl::Controls::TControl* AClient, TLMDAutoHideState AState);
	virtual bool __fastcall GetIsFloatingSite(void);
	virtual bool __fastcall GetIsFloatingDoc(void);
	virtual TLMDFloatingForm* __fastcall GetFloatingForm(void);
	virtual void __fastcall NotifyFloatForm(void);
	virtual bool __fastcall WantsTransparency(const System::Types::TPoint &P);
	virtual bool __fastcall ShowPanelHeader(TLMDDockPanel* APanel);
	virtual Lmddckstyleelems::TLMDPanelBtnKinds __fastcall GetPanelButtons(TLMDDockPanel* APanel);
	virtual void __fastcall PanelButtonClick(TLMDDockPanel* APanel, Lmddckstyleelems::TLMDPanelBtnKind B);
	void __fastcall PopupTabsMenu(TLMDDockZone* AZone);
	void __fastcall DoDockTask(void);
	void __fastcall ResetUndockedClientPnls(void);
	
public:
	__fastcall virtual TLMDDockSite(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDockSite(void);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	DYNAMIC void __fastcall DockDrop(Vcl::Controls::TDragDockObject* Source, int X, int Y);
	void __fastcall DockControl(Vcl::Controls::TControl* AControl, TLMDDockZone* ADropOnZone = (TLMDDockZone*)(0x0), Vcl::Controls::TAlign AZoneSide = (Vcl::Controls::TAlign)(0x5), int ATabIndex = 0xffffffff, bool ASelectPage = true);
	void __fastcall UpdateLayout(bool AFireChangeEvent = false, TLMDDockPanel* AActivate = (TLMDDockPanel*)(0x0));
	TLMDDockPanel* __fastcall FindPanelByClient(Vcl::Controls::TControl* AClient);
	TLMDDockZone* __fastcall FindZoneByClient(Vcl::Controls::TControl* AClient);
	TLMDDockSiteHitTest __fastcall GetHitTest(const System::Types::TPoint &P);
	__property bool IsFloatingSite = {read=GetIsFloatingSite, nodefault};
	__property bool IsFloatingDoc = {read=GetIsFloatingDoc, nodefault};
	__property TLMDFloatingForm* FloatingForm = {read=GetFloatingForm};
	__property int PanelCount = {read=GetPanelCount, nodefault};
	__property TLMDDockPanel* Panels[int AIndex] = {read=GetPanels};
	__property TLMDDockZone* RootZone = {read=GetRootZone};
	__property TLMDDockZone* SpaceZone = {read=GetSpaceZone};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property TLMDDockManager* Manager = {read=FManager, write=SetManager};
	__property TLMDDockSiteLockMode LockMode = {read=FLockMode, write=SetLockMode, default=0};
	__property bool LoadDesignLayout = {read=FLoadDesignLayout, write=FLoadDesignLayout, default=1};
	__property bool UseSpace = {read=FUseSpace, write=SetUseSpace, default=1};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TLMDDockSiteOnDockOver OnDockOver = {read=FOnDockOver, write=FOnDockOver};
	__property TLMDDockSiteOnDockDrop OnDockDrop = {read=FOnDockDrop, write=FOnDockDrop};
	__property TLMDDockSiteOnCustomInsertQuery OnCustomInsertQuery = {read=FOnCustomInsertQuery, write=FOnCustomInsertQuery};
	__property TLMDDockSiteOnCustomInsert OnCustomInsert = {read=FOnCustomInsert, write=FOnCustomInsert};
	__property TLMDDockSiteOnUpdateHotSpots OnUpdateHotSpots = {read=FOnUpdateHotSpots, write=FOnUpdateHotSpots};
	__property TLMDDockSiteOnAutoHide OnAutoHide = {read=FOnAutoHide, write=FOnAutoHide};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Font;
	__property ParentFont = {default=1};
	__property OnGetSiteInfo;
	__property BiDiMode;
	__property Constraints;
	__property Enabled = {default=1};
	__property ParentBiDiMode = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnCanResize;
	__property OnClick;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnUnDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDockSite(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
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


typedef void __fastcall (__closure *TLMDDockGetCompId)(System::TObject* Sender, System::Classes::TComponent* AComponent, Lmdtypes::TLMDString &AId);

typedef void __fastcall (__closure *TLMDDockGetComp)(System::TObject* Sender, const Lmdtypes::TLMDString AId, System::Classes::TComponent* &AComponent);

typedef void __fastcall (__closure *TLMDDockSaveSite)(System::TObject* Sender, TLMDDockSite* ASite, bool AFloat, bool &ASave);

typedef void __fastcall (__closure *TLMDDockStreamAppInfo)(System::TObject* Sender, const Lmdxml::_di_ILMDXmlDocument Xml);

typedef void __fastcall (__closure *TLMDDockSiteEvent)(System::TObject* Sender, TLMDDockSite* ASite);

typedef void __fastcall (__closure *TLMDDockAttachSite)(System::TObject* Sender, TLMDDockSite* ASite, bool &Attach);

typedef void __fastcall (__closure *TLMDDockGetClientKind)(System::TObject* Sender, Vcl::Controls::TControl* AClient, TLMDDockClientKind &AKind);

class PASCALIMPLEMENTATION TLMDDockManager : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	TLMDDockManager* FNext;
	Lmddckstyles::TLMDDockStyle* FStyle;
	Lmddckstyleelems::TLMDDockElems* FDockElems;
	bool FPersistFloatSize;
	bool FStayFloatFormsOnTop;
	Lmddckstyleelems::TLMDPanelBtnKinds FFloatFormButtons;
	bool FUseTabbedDocs;
	System::Classes::TNotifyEvent FOnLayoutChange;
	TLMDDockGetComp FOnGetComp;
	TLMDDockGetCompId FOnGetCompId;
	TLMDDockSaveSite FOnSaveSite;
	TLMDDockStreamAppInfo FOnWriteAppInfo;
	TLMDDockStreamAppInfo FOnReadAppInfo;
	TLMDDockStreamAppInfo FBeforeRead;
	TLMDDockStreamAppInfo FBeforeWrite;
	TLMDDockAttachSite FOnAttachFloatingSite;
	TLMDDockSiteEvent FOnDestroyFloatingSite;
	TLMDDockSiteEvent FOnCreateFloatingSite;
	TLMDDockGetClientKind FOnGetClientKind;
	bool FScrollDocTabs;
	TLMDDockSite* __fastcall FindSite(bool AFloating, const Lmdtypes::TLMDString AId);
	void __fastcall IdToCompProc(const Lmdtypes::TLMDString AId, /* out */ System::Classes::TComponent* &AComp);
	void __fastcall CompToIdProc(System::Classes::TComponent* AComp, /* out */ Lmdtypes::TLMDString &AId);
	void __fastcall UpdateSites(void);
	void __fastcall SetStayFloatFormsOnTop(const bool Value);
	void __fastcall SetFloatFormButtons(const Lmddckstyleelems::TLMDPanelBtnKinds Value);
	void __fastcall SetUseTabbedDocs(const bool Value);
	int __fastcall GetSiteCount(void);
	TLMDDockSite* __fastcall GetSites(int AIndex);
	void __fastcall SetStyle(Lmddckstyles::TLMDDockStyle* const Value);
	Lmddckstyles::TLMDStyleName __fastcall GetStyleName(void);
	void __fastcall SetStyleName(const Lmddckstyles::TLMDStyleName Value);
	void __fastcall SetScrollDocTabs(const bool Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DoLayoutChange(void);
	virtual bool __fastcall AttachFloatingSite(TLMDDockSite* ASite);
	virtual void __fastcall FloatingSiteCreated(TLMDDockSite* ASite);
	virtual void __fastcall FloatingSiteDestroying(TLMDDockSite* ASite);
	virtual Lmdtypes::TLMDString __fastcall DoGetCompId(System::Classes::TComponent* AComp);
	virtual System::Classes::TComponent* __fastcall DoGetComp(const Lmdtypes::TLMDString AId);
	virtual bool __fastcall DoSaveSite(TLMDDockSite* ASite);
	virtual void __fastcall DoBeforeWrite(const Lmdxml::_di_ILMDXmlDocument Xml);
	virtual void __fastcall DoBeforeRead(const Lmdxml::_di_ILMDXmlDocument Xml);
	virtual void __fastcall DoWriteAppInfo(const Lmdxml::_di_ILMDXmlDocument Xml);
	virtual void __fastcall DoReadAppInfo(const Lmdxml::_di_ILMDXmlDocument Xml);
	virtual TLMDDockClientKind __fastcall DoGetClientKind(Vcl::Controls::TControl* AClient);
	
public:
	__fastcall virtual TLMDDockManager(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDockManager(void);
	void __fastcall SaveToStream(System::Classes::TStream* AStream);
	void __fastcall SaveToFile(const Lmdtypes::TLMDString AFileName);
	void __fastcall LoadFromStream(System::Classes::TStream* AStream);
	void __fastcall LoadFromFile(const Lmdtypes::TLMDString AFileName);
	void __fastcall ApplyDesignLayout(void);
	__property Lmddckstyles::TLMDDockStyle* Style = {read=FStyle, write=SetStyle};
	__property Lmddckstyleelems::TLMDDockElems* DockElems = {read=FDockElems};
	__property int SiteCount = {read=GetSiteCount, nodefault};
	__property TLMDDockSite* Sites[int AIndex] = {read=GetSites};
	
__published:
	__property Lmddckstyles::TLMDStyleName StyleName = {read=GetStyleName, write=SetStyleName};
	__property bool PersistFloatSize = {read=FPersistFloatSize, write=FPersistFloatSize, default=0};
	__property Lmddckstyleelems::TLMDPanelBtnKinds FloatFormButtons = {read=FFloatFormButtons, write=SetFloatFormButtons, default=12};
	__property bool ScrollDocTabs = {read=FScrollDocTabs, write=SetScrollDocTabs, default=1};
	__property bool UseTabbedDocs = {read=FUseTabbedDocs, write=SetUseTabbedDocs, default=1};
	__property bool StayFloatFormsOnTop = {read=FStayFloatFormsOnTop, write=SetStayFloatFormsOnTop, default=1};
	__property System::Classes::TNotifyEvent OnLayoutChange = {read=FOnLayoutChange, write=FOnLayoutChange};
	__property TLMDDockAttachSite OnAttachFloatingSite = {read=FOnAttachFloatingSite, write=FOnAttachFloatingSite};
	__property TLMDDockSiteEvent OnCreateFloatingSite = {read=FOnCreateFloatingSite, write=FOnCreateFloatingSite};
	__property TLMDDockSiteEvent OnDestroyFloatingSite = {read=FOnDestroyFloatingSite, write=FOnDestroyFloatingSite};
	__property TLMDDockGetCompId OnGetCompId = {read=FOnGetCompId, write=FOnGetCompId};
	__property TLMDDockGetComp OnGetComp = {read=FOnGetComp, write=FOnGetComp};
	__property TLMDDockSaveSite OnSaveSite = {read=FOnSaveSite, write=FOnSaveSite};
	__property TLMDDockStreamAppInfo BeforeWrite = {read=FBeforeWrite, write=FBeforeWrite};
	__property TLMDDockStreamAppInfo BeforeRead = {read=FBeforeRead, write=FBeforeRead};
	__property TLMDDockStreamAppInfo OnWriteAppInfo = {read=FOnWriteAppInfo, write=FOnWriteAppInfo};
	__property TLMDDockStreamAppInfo OnReadAppInfo = {read=FOnReadAppInfo, write=FOnReadAppInfo};
	__property TLMDDockGetClientKind OnGetClientKind = {read=FOnGetClientKind, write=FOnGetClientKind};
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


typedef void __fastcall (*TLMDGetDesignerSelection)(System::Classes::TComponent* AComponent, System::Classes::TList* ASelection);

typedef void __fastcall (*TLMDSetDesignedSelection)(System::Classes::TComponent* AComponent);

enum DECLSPEC_DENUM TLMDDesignerAction : unsigned char { paUnknown, paMove, paSelectChildren, paInsert };

typedef TLMDDesignerAction __fastcall (*TLMDGetDesignerAction)(System::Classes::TComponent* AComponent);

//-- var, const, procedure ---------------------------------------------------
static const Vcl::Controls::TAlign alDocTop = (Vcl::Controls::TAlign)(7);
static const Vcl::Controls::TAlign alDocBottom = (Vcl::Controls::TAlign)(8);
static const Vcl::Controls::TAlign alDocLeft = (Vcl::Controls::TAlign)(9);
static const Vcl::Controls::TAlign alDocRight = (Vcl::Controls::TAlign)(10);
extern DELPHI_PACKAGE TLMDGetDesignerSelection LMDGetDesignerSelectionProc;
extern DELPHI_PACKAGE TLMDSetDesignedSelection LMDSetDesignedSelectionProc;
extern DELPHI_PACKAGE TLMDGetDesignerAction LMDGetDesignerActionProc;
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDGetClientCaption(Vcl::Controls::TControl* AClient);
}	/* namespace Lmddcksite */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDCKSITE)
using namespace Lmddcksite;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddcksiteHPP
