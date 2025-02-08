// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDsgDesigner.pas' rev: 31.00 (Windows)

#ifndef LmddsgdesignerHPP
#define LmddsgdesignerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Consts.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Clipbrd.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.RTLConsts.hpp>
#include <Vcl.Themes.hpp>
#include <intfLMDBase.hpp>
#include <LMDUnicode.hpp>
#include <LMDTypes.hpp>
#include <LMDXML.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDUnicodeControl.hpp>
#include <LMDInsEditorWnds.hpp>
#include <LMDInsEditorUtils.hpp>
#include <LMDDsgClass.hpp>
#include <LMDDsgCst.hpp>
#include <LMDDsgObjects.hpp>
#include <LMDDsgModule.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddsgdesigner
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomDesignPanel;
class DELPHICLASS TLMDDesignPanel;
class DELPHICLASS ELMDDesigner;
class DELPHICLASS TLMDDesignerGrid;
class DELPHICLASS TLMDDesignerHiddenClasses;
class DELPHICLASS TLMDCustomDesigner;
class DELPHICLASS TLMDDesigner;
class DELPHICLASS ILMDDesignerNotifier;
class DELPHICLASS ILMDCompInsService;
class DELPHICLASS ILMDCompImageService;
class DELPHICLASS ILMDObjEditService;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomDesignPanel : public Vcl::Controls::TWinControl
{
	typedef Vcl::Controls::TWinControl inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	System::TObject* FEng;
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	Vcl::Forms::TCustomForm* FForm;
	Vcl::Controls::TControl* FScrollCtrl;
	void __fastcall SetEng(System::TObject* AEng);
	void __fastcall SetBorderStyle(const Vcl::Forms::TBorderStyle Value);
	bool __fastcall GetIsUsed(void);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMCursorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMBiDiModeChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentBiDiModeChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentShowHintChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	bool __fastcall GetAutoScroll(void);
	void __fastcall SetAutoScroll(const bool Value);
	Vcl::Forms::TControlScrollBar* __fastcall GetHorzScrollBar(void);
	void __fastcall SetHorzScrollBar(Vcl::Forms::TControlScrollBar* const Value);
	Vcl::Forms::TControlScrollBar* __fastcall GetVertScrollBar(void);
	void __fastcall SetVertScrollBar(Vcl::Forms::TControlScrollBar* const Value);
	void __fastcall UpdateFormParentWindow(void);
	void __fastcall UpdateFormBounds(void);
	void __fastcall UpdateEngFocus(void);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall CreateHandle(void);
	DYNAMIC Vcl::Menus::TPopupMenu* __fastcall GetPopupMenu(void);
	void __fastcall RootBoundsChanged(void);
	__property bool IsUsed = {read=GetIsUsed, nodefault};
	__property Vcl::Forms::TCustomForm* Form = {read=FForm};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property bool AutoScroll = {read=GetAutoScroll, write=SetAutoScroll, nodefault};
	__property Vcl::Forms::TControlScrollBar* HorzScrollBar = {read=GetHorzScrollBar, write=SetHorzScrollBar};
	__property Vcl::Forms::TControlScrollBar* VertScrollBar = {read=GetVertScrollBar, write=SetVertScrollBar};
	
public:
	__fastcall virtual TLMDCustomDesignPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomDesignPanel(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property TabStop = {default=1};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomDesignPanel(HWND ParentWindow) : Vcl::Controls::TWinControl(ParentWindow) { }
	
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


class PASCALIMPLEMENTATION TLMDDesignPanel : public TLMDCustomDesignPanel
{
	typedef TLMDCustomDesignPanel inherited;
	
public:
	__property IsUsed;
	__property Form;
	
__published:
	__property BorderStyle = {default=1};
	__property AutoScroll;
	__property HorzScrollBar;
	__property VertScrollBar;
	__property BiDiMode;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Color = {default=-16777211};
	__property Constraints;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property OnClick;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TLMDCustomDesignPanel.Create */ inline __fastcall virtual TLMDDesignPanel(System::Classes::TComponent* AOwner) : TLMDCustomDesignPanel(AOwner) { }
	/* TLMDCustomDesignPanel.Destroy */ inline __fastcall virtual ~TLMDDesignPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDesignPanel(HWND ParentWindow) : TLMDCustomDesignPanel(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDDesigner : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDDesigner(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDDesigner(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDDesigner(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDDesigner(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDDesigner(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDDesigner(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDDesigner(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDDesigner(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDDesigner(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDDesigner(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDDesigner(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDDesigner(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDDesigner(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDDesignerLockModeItem : unsigned char { lmNoMove, lmNoResize, lmNoDelete, lmNoInsertIn, lmNoCopy, lmCustom1, lmCustom2, lmCustom3, lmCustom4, lmCustom5, lmCustom6, lmCustom7, lmCustom8 };

typedef System::Set<TLMDDesignerLockModeItem, TLMDDesignerLockModeItem::lmNoMove, TLMDDesignerLockModeItem::lmCustom8> TLMDDesignerLockMode;

enum DECLSPEC_DENUM TLMDDesignerAlignType : unsigned char { atNoChanges, atLeftTop, atRightBottom, atSpaceEqually, atCenter, atCenterInWindow };

typedef System::Int8 TLMDDesignerGridSize;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDesignerGrid : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TLMDCustomDesigner* FDesigner;
	bool FVisible;
	TLMDDesignerGridSize FYStep;
	TLMDDesignerGridSize FXStep;
	System::Uitypes::TColor FColor;
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetXStep(const TLMDDesignerGridSize Value);
	void __fastcall SetYStep(const TLMDDesignerGridSize Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	
public:
	__fastcall TLMDDesignerGrid(TLMDCustomDesigner* AOwnerDesigner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TLMDDesignerGridSize XStep = {read=FXStep, write=SetXStep, default=8};
	__property TLMDDesignerGridSize YStep = {read=FYStep, write=SetYStep, default=8};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDDesignerGrid(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDesignerHiddenClasses : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Classes::TComponentClass operator[](int I) { return this->Items[I]; }
	
private:
	TLMDCustomDesigner* FDesigner;
	System::Classes::TList* FItems;
	int FUpdateCount;
	bool FChanged;
	int __fastcall GetCount(void);
	System::Classes::TComponentClass __fastcall GetItems(int I);
	void __fastcall Changed(void);
	
protected:
	virtual void __fastcall DoChange(void);
	
public:
	__fastcall TLMDDesignerHiddenClasses(TLMDCustomDesigner* AOwnerDesigner);
	__fastcall virtual ~TLMDDesignerHiddenClasses(void);
	int __fastcall Add(System::Classes::TComponentClass AClass);
	int __fastcall IndexOf(System::Classes::TComponentClass AClass);
	void __fastcall Delete(int AI);
	void __fastcall Remove(System::Classes::TComponentClass AClass);
	void __fastcall GetClasses(System::Classes::TList* AResult);
	void __fastcall SetClasses(System::Classes::TList* AClasses);
	void __fastcall Clear(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property System::Classes::TComponentClass Items[int I] = {read=GetItems/*, default*/};
	__property int Count = {read=GetCount, nodefault};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDDesignerHint : unsigned char { dhComponent, dhSize, dhMove, dhInsert };

typedef System::Set<TLMDDesignerHint, TLMDDesignerHint::dhComponent, TLMDDesignerHint::dhInsert> TLMDDesignerHints;

enum DECLSPEC_DENUM Lmddsgdesigner__6 : unsigned char { dmoAddDefaultItems, dmoAddCompEditorItems };

typedef System::Set<Lmddsgdesigner__6, Lmddsgdesigner__6::dmoAddDefaultItems, Lmddsgdesigner__6::dmoAddCompEditorItems> TLMDDesignerMenuOptions;

enum DECLSPEC_DENUM Lmddsgdesigner__7 : unsigned char { dsoUseCompInsertionService, dsoUseCompImageService, dsoUseObjEditService };

typedef System::Set<Lmddsgdesigner__7, Lmddsgdesigner__7::dsoUseCompInsertionService, Lmddsgdesigner__7::dsoUseObjEditService> TLMDDesignerServiceOptions;

typedef void __fastcall (__closure *TLMDDesignerOnComponentInsertingEvent)(System::TObject* Sender, System::Classes::TComponentClass &AComponentClass);

typedef void __fastcall (__closure *TLMDDesignerOnComponentHintEvent)(System::TObject* Sender, System::Classes::TComponent* AComponent, Lmdtypes::TLMDString &AHint);

typedef void __fastcall (__closure *TLMDDesignerOnNotificationEvent)(System::TObject* Sender, System::Classes::TPersistent* AnObject, System::Classes::TOperation Operation);

typedef void __fastcall (__closure *TLMDDesignerOnGetImageIndex)(System::TObject* Sender, System::Classes::TComponentClass AComponentClass, int &AImageIndex);

typedef void __fastcall (__closure *TLMDDesignerOnGetTransparence)(System::TObject* Sender, Vcl::Controls::TControl* AControl, bool &ATransparent);

typedef void __fastcall (__closure *TLMDDesignerOnShowNonvisualComponent)(System::TObject* Sender, System::Classes::TComponent* AComponent, bool &AShowComponent);

class PASCALIMPLEMENTATION TLMDCustomDesigner : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	System::TObject* FEng;
	Lmdsvcpvdr::TLMDServiceProvider* FServiceProvider;
	TLMDDesignerServiceOptions FServiceOptions;
	Lmddsgmodule::TLMDModule* FModule;
	Lmddsgmodule::ILMDModuleNotifier* FModuleNotifier;
	bool FSnapToGrid;
	bool FShowAlignLines;
	bool FActive;
	System::Classes::TNotifyEvent FOnComponentInserted;
	TLMDDesignerOnComponentInsertingEvent FOnComponentInserting;
	TLMDDesignerGrid* FGrid;
	Lmddsgobjects::TLMDDesignObjects* FSelection;
	System::TObject* FSelnNotifier;
	Lmddsgobjects::TLMDDesignObjects* FAllComponents;
	TLMDCustomDesignPanel* FDesignPanel;
	System::Classes::TNotifyEvent FOnChange;
	TLMDDesignerOnComponentHintEvent FOnComponentHint;
	TLMDDesignerHints FHints;
	Vcl::Menus::TPopupMenu* FTempMenu;
	Vcl::Forms::TCloseEvent FOnDesignFormClose;
	Vcl::Menus::TPopupMenu* FPopupMenu;
	Vcl::Controls::TContextPopupEvent FOnContextPopup;
	System::Uitypes::TColor FHandleClr;
	System::Uitypes::TColor FMultySelectHandleClr;
	System::Uitypes::TColor FHandleBorderClr;
	System::Uitypes::TColor FInactiveHandleClr;
	System::Uitypes::TColor FInactiveHandleBorderClr;
	System::Uitypes::TColor FLockedHandleClr;
	System::Uitypes::TColor FMultySelectHandleBorderClr;
	Lmdtypes::TLMDString FClipboardFormat;
	bool FClipbrdFormatRegistered;
	System::Word FClipboardFormatWord;
	Vcl::Controls::TKeyEvent FOnKeyUp;
	Vcl::Controls::TKeyEvent FOnKeyDown;
	Vcl::Controls::TKeyPressEvent FOnKeyPress;
	TLMDDesignerOnNotificationEvent FOnNotification;
	System::Classes::TNotifyEvent FOnDblClick;
	Vcl::Controls::TDragDropEvent FOnDragDrop;
	Vcl::Controls::TDragOverEvent FOnDragOver;
	bool FComponentContextPopup;
	Vcl::Controls::TMouseEvent FOnMouseUp;
	Vcl::Controls::TMouseEvent FOnMouseDown;
	Vcl::Controls::TMouseMoveEvent FOnMouseMove;
	Vcl::Controls::TMouseWheelEvent FOnMouseWheel;
	Vcl::Controls::TMouseWheelUpDownEvent FOnMouseWheelUp;
	Vcl::Controls::TMouseWheelUpDownEvent FOnMouseWheelDown;
	int FWheelAccumulator;
	System::Classes::TNotifyEvent FOnClick;
	bool FShowNonvisualComponents;
	bool FShowComponentCaptions;
	Vcl::Graphics::TFont* FComponentCaptionsFont;
	TLMDDesignerOnGetTransparence FOnGetTransparence;
	TLMDDesignerOnGetImageIndex FOnGetImageIndex;
	Vcl::Controls::TImageList* FNonvisualComponentImages;
	Vcl::Imglist::TChangeLink* FNonvisualCompImagesChangeLink;
	TLMDDesignerHiddenClasses* FHiddenClasses;
	TLMDDesignerOnShowNonvisualComponent FOnShowNonvisualComponent;
	int FNonvisualComponentWidth;
	int FNonvisualComponentHeight;
	bool FExcludeRoot;
	TLMDDesignerMenuOptions FMenuOptions;
	Lmdinseditorwnds::TLMDEditorWindowManager* FEditorWindows;
	Lmdinseditorutils::TLMDEditorUtils* FEditorUtils;
	bool FShowRootResizers;
	void __fastcall GridParamsChanged(void);
	void __fastcall RegisterClipboardFormat(void);
	void __fastcall ContextPopup(const System::Types::TPoint &AMousePos);
	void __fastcall ClearTempMenuItems(Vcl::Menus::TPopupMenu* AMenu);
	void __fastcall AddDefaultMenuItems(Vcl::Menus::TPopupMenu* AMenu);
	bool __fastcall DoKeyDown(Winapi::Messages::TWMKey &AMessage);
	bool __fastcall DoKeyPress(Winapi::Messages::TWMKey &AMessage);
	bool __fastcall DoKeyUp(Winapi::Messages::TWMKey &AMessage);
	void __fastcall CompsChangeNotification(System::TObject* Sender, System::Classes::TList* AChangedComps);
	void __fastcall SetActive(const bool Value);
	void __fastcall SetSelection(Lmddsgobjects::TLMDDesignObjects* const Value);
	void __fastcall SetAllComponents(Lmddsgobjects::TLMDDesignObjects* const Value);
	void __fastcall SetExcludeRoot(const bool Value);
	void __fastcall SetModule(Lmddsgmodule::TLMDModule* const Value);
	void __fastcall SetDesignPanel(TLMDCustomDesignPanel* const Value);
	bool __fastcall GetRootVisible(void);
	void __fastcall SetRootVisible(const bool Value);
	void __fastcall SetPopupMenu(Vcl::Menus::TPopupMenu* const Value);
	void __fastcall SetHandleBorderClr(const System::Uitypes::TColor Value);
	void __fastcall SetHandleClr(const System::Uitypes::TColor Value);
	void __fastcall SetInactiveHandleBorderClr(const System::Uitypes::TColor Value);
	void __fastcall SetInactiveHandleClr(const System::Uitypes::TColor Value);
	void __fastcall SetLockedHandleClr(const System::Uitypes::TColor Value);
	void __fastcall SetMultySelectHandleBorderClr(const System::Uitypes::TColor Value);
	void __fastcall SetMultySelectHandleClr(const System::Uitypes::TColor Value);
	void __fastcall SetClipboardFormat(const Lmdtypes::TLMDString Value);
	void __fastcall SetGrid(TLMDDesignerGrid* const Value);
	bool __fastcall GetFocused(void);
	bool __fastcall IsDefaultFormat(void);
	void __fastcall SetShowNonvisualComponents(const bool Value);
	void __fastcall SetShowComponentCaptions(const bool Value);
	void __fastcall SetComponentCaptionsFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetNonvisualComponentImages(Vcl::Controls::TImageList* const Value);
	void __fastcall SetNonvisualComponentWidth(const int Value);
	void __fastcall SetNonvisualComponentHeight(const int Value);
	void __fastcall HiddenClassesChanged(void);
	bool __fastcall IsComponentHidden(System::Classes::TComponent* AComponent);
	void __fastcall NonvisualCompImagesChange(System::TObject* Sender);
	void __fastcall DoSaveLocks(Lmdxml::_di_ILMDXmlElement AParent, System::Classes::TComponent* AOwner);
	void __fastcall DoLoadLocks(Lmdxml::_di_ILMDXmlElement AParent, System::Classes::TComponent* AOwner);
	bool __fastcall HasLockedChildren(System::Classes::TComponent* AOwner);
	void __fastcall SetServiceProvider(Lmdsvcpvdr::TLMDServiceProvider* const Value);
	void __fastcall SetShowRootResizers(const bool Value);
	void __fastcall SetServiceOptions(const TLMDDesignerServiceOptions Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall CheckActive(bool AIsActiveNeeded);
	DYNAMIC Vcl::Menus::TPopupMenu* __fastcall GetPopupMenu(void);
	virtual void __fastcall DoChange(void);
	virtual void __fastcall ComponentInserting(System::Classes::TComponentClass &AComponentClass);
	virtual void __fastcall ComponentInserted(void);
	virtual void __fastcall DoNotification(System::Classes::TPersistent* AnObject, System::Classes::TOperation Operation);
	virtual void __fastcall DoFocus(void);
	virtual void __fastcall DoComponentHint(System::Classes::TComponent* AComponent, Lmdtypes::TLMDString &AHint);
	DYNAMIC void __fastcall DoContextPopup(const System::Types::TPoint &AMousePos, bool &AHandled);
	virtual void __fastcall DesignFormClose(System::Uitypes::TCloseAction &Action);
	virtual void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall KeyUp(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton AButton, System::Classes::TShiftState AShift, int AX, int AY);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState AShift, int AX, int AY);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton AButton, System::Classes::TShiftState AShift, int AX, int AY);
	DYNAMIC bool __fastcall DoMouseWheel(System::Classes::TShiftState AShift, int AWheelDelta, const System::Types::TPoint &AMousePos);
	DYNAMIC bool __fastcall DoMouseWheelDown(System::Classes::TShiftState AShift, const System::Types::TPoint &AMousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(System::Classes::TShiftState AShift, const System::Types::TPoint &AMousePos);
	virtual void __fastcall DblClick(void);
	virtual void __fastcall Click(void);
	DYNAMIC void __fastcall DragOver(System::TObject* ASource, int AX, int AY, System::Uitypes::TDragState AState, bool &AAccept);
	virtual bool __fastcall DoGetTransparence(Vcl::Controls::TControl* AControl);
	virtual void __fastcall DoGetImageParams(System::Classes::TComponentClass AComponentClass, Vcl::Controls::TImageList* &AImageList, int &AImageIndex);
	virtual void __fastcall DoShowNonvisualComponent(System::Classes::TComponent* AComponent, bool &AShowComponent);
	__property Lmdsvcpvdr::TLMDServiceProvider* ServiceProvider = {read=FServiceProvider, write=SetServiceProvider};
	__property TLMDDesignerServiceOptions ServiceOptions = {read=FServiceOptions, write=SetServiceOptions, default=7};
	__property int WheelAccumulator = {read=FWheelAccumulator, write=FWheelAccumulator, nodefault};
	__property bool Active = {read=FActive, write=SetActive, nodefault};
	__property bool Focused = {read=GetFocused, nodefault};
	__property Lmddsgmodule::TLMDModule* Module = {read=FModule, write=SetModule};
	__property Lmddsgobjects::TLMDDesignObjects* Selection = {read=FSelection, write=SetSelection};
	__property Lmddsgobjects::TLMDDesignObjects* AllComponents = {read=FAllComponents, write=SetAllComponents};
	__property Lmdinseditorwnds::TLMDEditorWindowManager* EditorWindows = {read=FEditorWindows};
	__property bool ExcludeRoot = {read=FExcludeRoot, write=SetExcludeRoot, default=0};
	__property bool RootVisible = {read=GetRootVisible, write=SetRootVisible, nodefault};
	__property TLMDCustomDesignPanel* DesignPanel = {read=FDesignPanel, write=SetDesignPanel};
	__property TLMDDesignerGrid* Grid = {read=FGrid, write=SetGrid};
	__property bool SnapToGrid = {read=FSnapToGrid, write=FSnapToGrid, default=1};
	__property bool ShowAlignLines = {read=FShowAlignLines, write=FShowAlignLines, default=1};
	__property TLMDDesignerHints Hints = {read=FHints, write=FHints, default=15};
	__property Vcl::Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=SetPopupMenu};
	__property System::Uitypes::TColor HandleColor = {read=FHandleClr, write=SetHandleClr, default=0};
	__property System::Uitypes::TColor HandleBorderColor = {read=FHandleBorderClr, write=SetHandleBorderClr, default=0};
	__property System::Uitypes::TColor MultiSelectHandleColor = {read=FMultySelectHandleClr, write=SetMultySelectHandleClr, default=8421504};
	__property System::Uitypes::TColor MultiSelectHandleBorderColor = {read=FMultySelectHandleBorderClr, write=SetMultySelectHandleBorderClr, default=8421504};
	__property System::Uitypes::TColor InactiveHandleColor = {read=FInactiveHandleClr, write=SetInactiveHandleClr, default=8421504};
	__property System::Uitypes::TColor InactiveHandleBorderColor = {read=FInactiveHandleBorderClr, write=SetInactiveHandleBorderClr, default=0};
	__property System::Uitypes::TColor LockedHandleColor = {read=FLockedHandleClr, write=SetLockedHandleClr, default=255};
	__property Lmdtypes::TLMDString ClipboardFormat = {read=FClipboardFormat, write=SetClipboardFormat, stored=IsDefaultFormat};
	__property bool ComponentContextPopup = {read=FComponentContextPopup, write=FComponentContextPopup, default=1};
	__property bool ShowNonvisualComponents = {read=FShowNonvisualComponents, write=SetShowNonvisualComponents, default=0};
	__property bool ShowComponentCaptions = {read=FShowComponentCaptions, write=SetShowComponentCaptions, default=0};
	__property Vcl::Graphics::TFont* ComponentCaptionsFont = {read=FComponentCaptionsFont, write=SetComponentCaptionsFont};
	__property Vcl::Controls::TImageList* NonvisualComponentImages = {read=FNonvisualComponentImages, write=SetNonvisualComponentImages};
	__property int NonvisualComponentWidth = {read=FNonvisualComponentWidth, write=SetNonvisualComponentWidth, default=28};
	__property int NonvisualComponentHeight = {read=FNonvisualComponentHeight, write=SetNonvisualComponentHeight, default=28};
	__property TLMDDesignerHiddenClasses* HiddenClasses = {read=FHiddenClasses};
	__property TLMDDesignerMenuOptions MenuOptions = {read=FMenuOptions, write=FMenuOptions, default=2};
	__property bool ShowRootResizers = {read=FShowRootResizers, write=SetShowRootResizers, default=0};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TLMDDesignerOnComponentInsertingEvent OnComponentInserting = {read=FOnComponentInserting, write=FOnComponentInserting};
	__property System::Classes::TNotifyEvent OnComponentInserted = {read=FOnComponentInserted, write=FOnComponentInserted};
	__property TLMDDesignerOnNotificationEvent OnNotification = {read=FOnNotification, write=FOnNotification};
	__property TLMDDesignerOnComponentHintEvent OnComponentHint = {read=FOnComponentHint, write=FOnComponentHint};
	__property Vcl::Forms::TCloseEvent OnDesignFormClose = {read=FOnDesignFormClose, write=FOnDesignFormClose};
	__property TLMDDesignerOnGetTransparence OnGetTransparence = {read=FOnGetTransparence, write=FOnGetTransparence};
	__property TLMDDesignerOnGetImageIndex OnGetImageIndex = {read=FOnGetImageIndex, write=FOnGetImageIndex};
	__property TLMDDesignerOnShowNonvisualComponent OnShowNonvisualComponent = {read=FOnShowNonvisualComponent, write=FOnShowNonvisualComponent};
	__property Vcl::Controls::TContextPopupEvent OnContextPopup = {read=FOnContextPopup, write=FOnContextPopup};
	__property Vcl::Controls::TKeyEvent OnKeyDown = {read=FOnKeyDown, write=FOnKeyDown};
	__property Vcl::Controls::TKeyPressEvent OnKeyPress = {read=FOnKeyPress, write=FOnKeyPress};
	__property Vcl::Controls::TKeyEvent OnKeyUp = {read=FOnKeyUp, write=FOnKeyUp};
	__property Vcl::Controls::TMouseEvent OnMouseDown = {read=FOnMouseDown, write=FOnMouseDown};
	__property Vcl::Controls::TMouseMoveEvent OnMouseMove = {read=FOnMouseMove, write=FOnMouseMove};
	__property Vcl::Controls::TMouseEvent OnMouseUp = {read=FOnMouseUp, write=FOnMouseUp};
	__property Vcl::Controls::TMouseWheelEvent OnMouseWheel = {read=FOnMouseWheel, write=FOnMouseWheel};
	__property Vcl::Controls::TMouseWheelUpDownEvent OnMouseWheelDown = {read=FOnMouseWheelDown, write=FOnMouseWheelDown};
	__property Vcl::Controls::TMouseWheelUpDownEvent OnMouseWheelUp = {read=FOnMouseWheelUp, write=FOnMouseWheelUp};
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property System::Classes::TNotifyEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
	__property Vcl::Controls::TDragDropEvent OnDragDrop = {read=FOnDragDrop, write=FOnDragDrop};
	__property Vcl::Controls::TDragOverEvent OnDragOver = {read=FOnDragOver, write=FOnDragOver};
	
public:
	__fastcall virtual TLMDCustomDesigner(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomDesigner(void);
	DYNAMIC void __fastcall DragDrop(System::TObject* ASource, int AX, int AY);
	System::Classes::TComponent* __fastcall ComponentAtPos(const System::Types::TPoint &APos);
	bool __fastcall CanFocus(void);
	void __fastcall SetFocus(void);
	bool __fastcall IsDesignComponent(System::Classes::TComponent* AComponent);
	void __fastcall GetComponentPosition(System::Classes::TComponent* AComponent, int &ALeft, int &ATop);
	void __fastcall SetComponentPosition(System::Classes::TComponent* AComponent, int ALeft, int ATop);
	void __fastcall CancelMode(void);
	void __fastcall UpdateComponent(int AIndex);
	void __fastcall SelectAll(void);
	void __fastcall DeleteSelectedComponents(void);
	void __fastcall LockComponent(System::Classes::TComponent* AComponent, TLMDDesignerLockMode ALockMode);
	void __fastcall LockAll(TLMDDesignerLockMode ALockMode);
	TLMDDesignerLockMode __fastcall GetLockMode(System::Classes::TComponent* AComponent);
	bool __fastcall TryGetLockMode(System::Classes::TComponent* AComponent, /* out */ TLMDDesignerLockMode &ALockMode);
	void __fastcall ClearAllLocks(void);
	void __fastcall SaveLockState(System::Classes::TStream* AStream)/* overload */;
	void __fastcall SaveLockState(const Lmdtypes::TLMDString AFileName)/* overload */;
	void __fastcall LoadLockState(System::Classes::TStream* AStream)/* overload */;
	void __fastcall LoadLockState(const Lmdtypes::TLMDString AFileName)/* overload */;
	void __fastcall UpdateSelected(void);
	void __fastcall LockSelected(TLMDDesignerLockMode ALockMode);
	void __fastcall AlignSelectedToGrid(void);
	void __fastcall AlignSelected(TLMDDesignerAlignType AHorzAlign, TLMDDesignerAlignType AVertAlign);
	void __fastcall BringSelectedToFront(void);
	void __fastcall SendSelectedToBack(void);
	bool __fastcall CanCopyToClipboard(void);
	bool __fastcall CanCutToClipboard(void);
	bool __fastcall CanPasteFromClipboard(void);
	void __fastcall CutToClipboard(void);
	void __fastcall CopyToClipboard(void);
	void __fastcall PasteFromClipboard(void);
	void __fastcall UpdateNonvisualComponents(void);
	void __fastcall UpdateAllComponentsCollection(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
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


class PASCALIMPLEMENTATION TLMDDesigner : public TLMDCustomDesigner
{
	typedef TLMDCustomDesigner inherited;
	
private:
	void __fastcall ReadDeprecatedEventProp(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__property Active;
	__property Focused;
	__property RootVisible;
	__property HiddenClasses;
	__property EditorWindows;
	
__published:
	__property ServiceProvider;
	__property ServiceOptions = {default=7};
	__property Selection;
	__property AllComponents;
	__property ExcludeRoot = {default=0};
	__property ShowRootResizers = {default=0};
	__property Module;
	__property DesignPanel;
	__property Grid;
	__property SnapToGrid = {default=1};
	__property ShowAlignLines = {default=1};
	__property Hints = {default=15};
	__property PopupMenu;
	__property MenuOptions = {default=2};
	__property HandleColor = {default=0};
	__property HandleBorderColor = {default=0};
	__property MultiSelectHandleColor = {default=8421504};
	__property MultiSelectHandleBorderColor = {default=8421504};
	__property InactiveHandleColor = {default=8421504};
	__property InactiveHandleBorderColor = {default=0};
	__property LockedHandleColor = {default=255};
	__property ClipboardFormat = {default=0};
	__property ComponentContextPopup = {default=1};
	__property ShowNonvisualComponents = {default=0};
	__property ShowComponentCaptions = {default=0};
	__property ComponentCaptionsFont;
	__property NonvisualComponentImages;
	__property NonvisualComponentWidth = {default=28};
	__property NonvisualComponentHeight = {default=28};
	__property OnChange;
	__property OnComponentInserting;
	__property OnComponentInserted;
	__property OnNotification;
	__property OnComponentHint;
	__property OnDesignFormClose;
	__property OnGetTransparence;
	__property OnGetImageIndex;
	__property OnShowNonvisualComponent;
	__property OnContextPopup;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
public:
	/* TLMDCustomDesigner.Create */ inline __fastcall virtual TLMDDesigner(System::Classes::TComponent* AOwner) : TLMDCustomDesigner(AOwner) { }
	/* TLMDCustomDesigner.Destroy */ inline __fastcall virtual ~TLMDDesigner(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDDesignerNotifier : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall Focus(TLMDCustomDesigner* ASender) = 0 ;
	virtual void __fastcall ActiveChanged(TLMDCustomDesigner* ASender) = 0 ;
public:
	/* TObject.Create */ inline __fastcall ILMDDesignerNotifier(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDDesignerNotifier(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDCompInsService : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall Inserting(System::TObject* ASender, System::Classes::TComponentClass &AComponentClass) = 0 ;
	virtual void __fastcall Inserted(TLMDCustomDesigner* ADesigner) = 0 ;
public:
	/* TObject.Create */ inline __fastcall ILMDCompInsService(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDCompInsService(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDCompImageService : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall GetCompImageParams(System::TObject* ASender, System::Classes::TComponentClass AComponentClass, Vcl::Controls::TImageList* &AImageList, int &AImageIndex) = 0 ;
public:
	/* TObject.Create */ inline __fastcall ILMDCompImageService(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDCompImageService(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDObjEditService : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall DblClicked(System::TObject* ASender, System::Classes::TPersistent* AInstance) = 0 ;
	virtual void __fastcall AdjustMenu(System::TObject* ASender, System::Classes::TPersistent* AInstance, Vcl::Menus::TPopupMenu* AMenu) = 0 ;
public:
	/* TObject.Create */ inline __fastcall ILMDObjEditService(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDObjEditService(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall LMDIsPlacedOnDesignPanel(Vcl::Controls::TWinControl* AControl);
extern DELPHI_PACKAGE System::Classes::TList* __fastcall LMDGetDesignerList(void);
extern DELPHI_PACKAGE TLMDCustomDesigner* __fastcall LMDFindDesigner(Vcl::Controls::TWinControl* ARoot);
extern DELPHI_PACKAGE Lmdinseditorwnds::TLMDEditorWindowManager* __fastcall LMDFindDesignerEditorWindows(Vcl::Controls::TWinControl* ARoot);
}	/* namespace Lmddsgdesigner */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDSGDESIGNER)
using namespace Lmddsgdesigner;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddsgdesignerHPP
