// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIdeCompPltte.pas' rev: 31.00 (Windows)

#ifndef LmdidecomppltteHPP
#define LmdidecomppltteHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDInsClass.hpp>
#include <LMDUnicodeControl.hpp>
#include <LMDIdeCst.hpp>
#include <LMDIdeClass.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Themes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdidecomppltte
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDComponentPalette;
class DELPHICLASS TLMDCompPalettePageItem;
class DELPHICLASS TLMDCompPalettePage;
struct TLMDCompPaletteBtnInfo;
class DELPHICLASS TLMDComponentPalette;
class DELPHICLASS TLMDCompPaletteStyleHook;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDComponentPalette : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDComponentPalette(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDComponentPalette(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDComponentPalette(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDComponentPalette(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDComponentPalette(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDComponentPalette(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDComponentPalette(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDComponentPalette(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDComponentPalette(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDComponentPalette(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDComponentPalette(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDComponentPalette(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDComponentPalette(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCompPalettePageItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDCompPalettePage* FPage;
	int FImageIndex;
	System::Classes::TComponentClass FClass;
	Lmdtypes::TLMDString __fastcall GetDisplayString(void);
	
public:
	__fastcall TLMDCompPalettePageItem(TLMDCompPalettePage* APage);
	__fastcall virtual ~TLMDCompPalettePageItem(void);
	__property TLMDCompPalettePage* Page = {read=FPage};
	__property System::Classes::TComponentClass Class_ = {read=FClass};
	__property int ImageIndex = {read=FImageIndex, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCompPalettePage : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDCompPalettePageItem* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	TLMDComponentPalette* FPalette;
	Lmdtypes::TLMDString FName;
	System::Classes::TList* FItems;
	void __fastcall CleanupItems(void);
	TLMDCompPalettePageItem* __fastcall AddItem(System::Classes::TComponentClass AClass, int AImageIndex);
	void __fastcall RemoveItem(System::Classes::TComponentClass AClass);
	int __fastcall IndexOfItem(System::Classes::TComponentClass AClass);
	int __fastcall GetCount(void);
	TLMDCompPalettePageItem* __fastcall GetItems(int AIndex);
	
public:
	__fastcall TLMDCompPalettePage(TLMDComponentPalette* APalette, const Lmdtypes::TLMDString AName, int AIndex);
	__fastcall virtual ~TLMDCompPalettePage(void);
	__property TLMDComponentPalette* Palette = {read=FPalette};
	__property Lmdtypes::TLMDString Name = {read=FName};
	__property int Count = {read=GetCount, nodefault};
	__property TLMDCompPalettePageItem* Items[int AIndex] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDCompPaletteBtnKind : unsigned char { pbkArrow, pbkComponent, pbkDropDown };

struct DECLSPEC_DRECORD TLMDCompPaletteBtnInfo
{
public:
	TLMDCompPaletteBtnKind Kind;
	System::Types::TRect Bounds;
	TLMDCompPalettePageItem* PageItem;
};


typedef System::DynamicArray<TLMDCompPaletteBtnInfo> TLMDCompPaletteBtnInfos;

typedef void __fastcall (__closure *TLMDCompPaletteOnComponentHint)(System::TObject* Sender, TLMDCompPalettePageItem* AItem, Lmdtypes::TLMDString &AHint);

typedef void __fastcall (__closure *TLMDCompPaletteOnGetDropItemCaption)(System::TObject* Sender, TLMDCompPalettePageItem* AItem, Lmdtypes::TLMDString &ACaption);

class PASCALIMPLEMENTATION TLMDComponentPalette : public Vcl::Comctrls::TCustomTabControl
{
	typedef Vcl::Comctrls::TCustomTabControl inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDCompPaletteBtnInfo FBCBBugFix;
	System::Classes::TList* FPages;
	TLMDCompPalettePage* FActivePage;
	Lmdtypes::TLMDString FStandardPage;
	TLMDCompPaletteBtnInfos FButtons;
	int FCompBtnCount;
	TLMDCompPalettePageItem* FSelectedItem;
	int FHotButton;
	Vcl::Controls::TImageList* FImages;
	Vcl::Imglist::TChangeLink* FImagesChangeLink;
	Vcl::Graphics::TBitmap* FArrowBitmap;
	Vcl::Graphics::TBitmap* FDropDownBitmap;
	Lmdsvcpvdr::TLMDServiceProvider* FServiceProvider;
	System::TObject* FHint;
	int FLastHintButton;
	Vcl::Menus::TPopupMenu* FDropList;
	bool FComponentHints;
	TLMDCompPaletteOnComponentHint FOnComponentHint;
	TLMDCompPaletteOnGetDropItemCaption FOnGetDropItemCaption;
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMCancelMode(Vcl::Controls::TCMCancelMode &Message);
	void __fastcall InsertPage(TLMDCompPalettePage* APage, int AIndex);
	void __fastcall RemovePage(TLMDCompPalettePage* APage);
	TLMDCompPalettePage* __fastcall FindPage(const System::UnicodeString AName);
	TLMDCompPalettePage* __fastcall FindByCompClass(System::Classes::TComponentClass ACompClass);
	int __fastcall ButtonByItem(TLMDCompPalettePageItem* AItem);
	void __fastcall ClearPages(bool AClearStdPage);
	Vcl::Graphics::TBitmap* __fastcall GetArrowBitmap(void);
	Vcl::Graphics::TBitmap* __fastcall GetDropDownBitmap(void);
	void __fastcall ImagesChange(System::TObject* Sender);
	void __fastcall DropListClick(System::TObject* Sender);
	int __fastcall GetPageCount(void);
	TLMDCompPalettePage* __fastcall GetPages(int AIndex);
	void __fastcall SetStandardPage(const Lmdtypes::TLMDString Value);
	bool __fastcall IsStandardPageStored(void);
	HIDESBASE void __fastcall SetImages(Vcl::Controls::TImageList* const Value);
	System::Classes::TComponentClass __fastcall GetSelectedClass(void);
	void __fastcall SetActivePage(TLMDCompPalettePage* const Value);
	void __fastcall SetSelectedItem(TLMDCompPalettePageItem* const Value);
	void __fastcall SetServiceProvider(Lmdsvcpvdr::TLMDServiceProvider* const Value);
	void __fastcall SetComponentHints(const bool Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall PaintWindow(HDC DC);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall Resize(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DoComponentHint(TLMDCompPalettePageItem* AItem, Lmdtypes::TLMDString &AHint);
	int __fastcall ButtonAtPos(int AX, int AY);
	void __fastcall PaintPage(Vcl::Graphics::TCanvas* C);
	void __fastcall PaintButton(Vcl::Graphics::TCanvas* C, int AIndex);
	void __fastcall PaintDropListItem(System::TObject* Sender, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall UpdateTabs(void);
	void __fastcall UpdatePage(bool AInvalidate = true);
	void __fastcall UpdateTracking(void)/* overload */;
	void __fastcall UpdateTracking(bool AInvalidate, bool AMouseDown, /* out */ bool &ADropList)/* overload */;
	void __fastcall UpdateHint(void);
	void __fastcall DoDropList(void);
	
public:
	__fastcall virtual TLMDComponentPalette(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDComponentPalette(void);
	void __fastcall RegisterComponent(const Lmdtypes::TLMDString APageName, System::Classes::TComponentClass AClass, int AImageIndex)/* overload */;
	void __fastcall RegisterComponent(System::Classes::TComponentClass AClass, int AImageIndex)/* overload */;
	void __fastcall UnregisterComponent(System::Classes::TComponentClass AClass);
	TLMDCompPalettePageItem* __fastcall FindItem(System::Classes::TComponentClass AClass);
	__property int PageCount = {read=GetPageCount, nodefault};
	__property TLMDCompPalettePage* Pages[int AIndex] = {read=GetPages};
	__property TLMDCompPalettePage* ActivePage = {read=FActivePage, write=SetActivePage};
	__property TLMDCompPalettePageItem* SelectedItem = {read=FSelectedItem, write=SetSelectedItem};
	__property System::Classes::TComponentClass SelectedClass = {read=GetSelectedClass};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Lmdtypes::TLMDString StandardPage = {read=FStandardPage, write=SetStandardPage, stored=IsStandardPageStored};
	__property Vcl::Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property Lmdsvcpvdr::TLMDServiceProvider* ServiceProvider = {read=FServiceProvider, write=SetServiceProvider};
	__property bool ComponentHints = {read=FComponentHints, write=SetComponentHints, default=1};
	__property TLMDCompPaletteOnComponentHint OnComponentHint = {read=FOnComponentHint, write=FOnComponentHint};
	__property TLMDCompPaletteOnGetDropItemCaption OnGetDropItemCaption = {read=FOnGetDropItemCaption, write=FOnGetDropItemCaption};
	__property Height = {default=65};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
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
	__property Visible = {default=1};
	__property TabHeight = {default=0};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDComponentPalette(HWND ParentWindow) : Vcl::Comctrls::TCustomTabControl(ParentWindow) { }
	
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


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCompPaletteStyleHook : public Vcl::Comctrls::TTabControlStyleHook
{
	typedef Vcl::Comctrls::TTabControlStyleHook inherited;
	
protected:
	virtual void __fastcall Paint(Vcl::Graphics::TCanvas* Canvas);
public:
	/* TTabControlStyleHook.Create */ inline __fastcall virtual TLMDCompPaletteStyleHook(Vcl::Controls::TWinControl* AControl) : Vcl::Comctrls::TTabControlStyleHook(AControl) { }
	/* TTabControlStyleHook.Destroy */ inline __fastcall virtual ~TLMDCompPaletteStyleHook(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdidecomppltte */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIDECOMPPLTTE)
using namespace Lmdidecomppltte;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdidecomppltteHPP
