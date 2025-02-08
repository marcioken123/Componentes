// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIdeCompBar.pas' rev: 31.00 (Windows)

#ifndef LmdidecompbarHPP
#define LmdidecompbarHPP

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
#include <Vcl.GraphUtil.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDDsgClass.hpp>
#include <LMDUnicodeControl.hpp>
#include <LMDIdeCst.hpp>
#include <LMDIdeClass.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Themes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdidecompbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDComponentBar;
class DELPHICLASS TLMDCompBarItem;
class DELPHICLASS TLMDCompBarPage;
struct TLMDComponentBarRowInfo;
class DELPHICLASS TLMDComponentBar;
class DELPHICLASS TLMDCompBarStyleHook;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDComponentBar : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDComponentBar(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDComponentBar(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDComponentBar(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDComponentBar(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDComponentBar(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDComponentBar(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDComponentBar(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDComponentBar(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDComponentBar(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDComponentBar(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDComponentBar(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDComponentBar(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDComponentBar(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCompBarItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDCompBarPage* FPage;
	int FImageIndex;
	System::Classes::TComponentClass FClass;
	Lmdtypes::TLMDString __fastcall GetDisplayString(void);
	
public:
	__fastcall TLMDCompBarItem(TLMDCompBarPage* APage);
	__fastcall virtual ~TLMDCompBarItem(void);
	__property TLMDCompBarPage* Page = {read=FPage};
	__property System::Classes::TComponentClass Class_ = {read=FClass};
	__property int ImageIndex = {read=FImageIndex, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCompBarPage : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDCompBarItem* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	TLMDComponentBar* FBar;
	Lmdtypes::TLMDString FName;
	System::Classes::TList* FItems;
	bool FExpanded;
	void __fastcall InternalSetExpanded(bool AAutoCollapse, bool AUpdateLayout, bool AValue);
	void __fastcall CleanupItems(void);
	TLMDCompBarItem* __fastcall AddItem(System::Classes::TComponentClass AClass, int AImageIndex);
	void __fastcall RemoveItem(System::Classes::TComponentClass AClass);
	int __fastcall IndexOfItem(System::Classes::TComponentClass AClass);
	int __fastcall GetCount(void);
	TLMDCompBarItem* __fastcall GetItems(int AIndex);
	void __fastcall SetExpanded(const bool Value);
	
public:
	__fastcall TLMDCompBarPage(TLMDComponentBar* ABar, const Lmdtypes::TLMDString AName, int AIndex);
	__fastcall virtual ~TLMDCompBarPage(void);
	__property TLMDComponentBar* Bar = {read=FBar};
	__property Lmdtypes::TLMDString Name = {read=FName};
	__property int Count = {read=GetCount, nodefault};
	__property TLMDCompBarItem* Items[int AIndex] = {read=GetItems/*, default*/};
	__property bool Expanded = {read=FExpanded, write=SetExpanded, nodefault};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDComponentBarPageStyle : unsigned char { psBDS, psFlat };

typedef void __fastcall (__closure *TLMDComponentBarOnGetItemCaption)(System::TObject* Sender, TLMDCompBarItem* AItem, Lmdtypes::TLMDString &ACaption);

enum DECLSPEC_DENUM TLMDComponentBarRowKind : unsigned char { prkPageHeader, prkItem };

enum DECLSPEC_DENUM TLMDComponentBarRowPaintState : unsigned char { prpsNormal, prpsHot, prpsSelected, prpsSelectedDown };

struct DECLSPEC_DRECORD TLMDComponentBarRowInfo
{
public:
	TLMDComponentBarRowKind Kind;
	System::Types::TRect Bounds;
	System::TObject* Data;
	TLMDComponentBarRowPaintState PaintState;
};


typedef System::DynamicArray<TLMDComponentBarRowInfo> TLMDComponentBarRowInfos;

class PASCALIMPLEMENTATION TLMDComponentBar : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDComponentBarRowInfo FBCBBugFix;
	System::Classes::TList* FPages;
	Vcl::Controls::TImageList* FImages;
	Vcl::Imglist::TChangeLink* FImagesChangeLink;
	TLMDCompBarItem* FSelectedItem;
	Lmdtypes::TLMDString FStandardPage;
	Lmdsvcpvdr::TLMDServiceProvider* FServiceProvider;
	TLMDComponentBarRowInfos FRows;
	int FRowsHeight;
	int FHotRow;
	int FScrollPos;
	System::Uitypes::TColor FHotItemColor;
	System::Uitypes::TColor FSelectedItemColor;
	Vcl::Graphics::TFont* FCategoryFont;
	bool FAutoCollapse;
	bool FMouseDown;
	TLMDComponentBarOnGetItemCaption FOnGetItemCaption;
	System::Classes::TNotifyEvent FOnChange;
	TLMDComponentBarPageStyle FPageStyle;
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMCancelMode(Vcl::Controls::TCMCancelMode &Message);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Message);
	void __fastcall InsertPage(TLMDCompBarPage* APage, int AIndex);
	void __fastcall RemovePage(TLMDCompBarPage* APage);
	TLMDCompBarPage* __fastcall FindPage(const System::UnicodeString AName);
	TLMDCompBarPage* __fastcall FindByCompClass(System::Classes::TComponentClass ACompClass);
	void __fastcall ClearPages(bool AClearStdPage);
	void __fastcall ImagesChange(System::TObject* Sender);
	int __fastcall GetPageCount(void);
	TLMDCompBarPage* __fastcall GetPages(int AIndex);
	void __fastcall SetStandardPage(const Lmdtypes::TLMDString Value);
	bool __fastcall IsStandardPageStored(void);
	void __fastcall SetImages(Vcl::Controls::TImageList* const Value);
	System::Classes::TComponentClass __fastcall GetSelectedClass(void);
	void __fastcall SetSelectedItem(TLMDCompBarItem* const Value);
	void __fastcall SetServiceProvider(Lmdsvcpvdr::TLMDServiceProvider* const Value);
	int __fastcall RowAtPos(int AX, int AY);
	int __fastcall RowByItem(TLMDCompBarItem* AItem);
	void __fastcall SetHotItemColor(const System::Uitypes::TColor Value);
	void __fastcall SetSelectedItemColor(const System::Uitypes::TColor Value);
	void __fastcall SetCategoryFont(Vcl::Graphics::TFont* const Value);
	void __fastcall CategoryFontChanged(System::TObject* Sender);
	bool __fastcall IsOnExpandButton(int AIndex, int AX);
	void __fastcall SetAutoCollapse(const bool Value);
	void __fastcall InternalSetSelectedItem(TLMDCompBarItem* AItem, bool AUpdateLayout);
	void __fastcall SetPageStyle(const TLMDComponentBarPageStyle Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall Resize(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC bool __fastcall DoMouseWheelDown(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall DblClick(void);
	System::Uitypes::TColor __fastcall GetThemedBackColor(void);
	System::Uitypes::TColor __fastcall GetThemedTextColor(TLMDComponentBarRowPaintState AState);
	System::Uitypes::TColor __fastcall GetThemedCategoryTextColor(void);
	void __fastcall GetThemedCategoryColors(/* out */ System::Uitypes::TColor &C1, /* out */ System::Uitypes::TColor &C2, /* out */ System::Uitypes::TColor &C3);
	virtual void __fastcall Paint(void);
	virtual Lmdtypes::TLMDString __fastcall GetItemCaption(TLMDCompBarItem* AItem);
	virtual void __fastcall Change(void);
	TLMDComponentBarRowPaintState __fastcall GetRowPaintState(int AIndex);
	void __fastcall PaintRow(int AIndex);
	void __fastcall UpdateLayout(bool AInvalidate = true);
	void __fastcall UpdateTracking(void)/* overload */;
	void __fastcall UpdateTracking(bool AInvalidate, bool AMouseDown)/* overload */;
	void __fastcall UpdateScrollBar(void);
	void __fastcall RestrictScrollPos(int &AScrollPos);
	void __fastcall SetScrollPosFromUI(int AValue);
	
public:
	__fastcall virtual TLMDComponentBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDComponentBar(void);
	void __fastcall RegisterComponent(const Lmdtypes::TLMDString APageName, System::Classes::TComponentClass AClass, int AImageIndex)/* overload */;
	void __fastcall RegisterComponent(System::Classes::TComponentClass AClass, int AImageIndex)/* overload */;
	void __fastcall UnregisterComponent(System::Classes::TComponentClass AClass);
	TLMDCompBarItem* __fastcall FindItem(System::Classes::TComponentClass AClass);
	__property int PageCount = {read=GetPageCount, nodefault};
	__property TLMDCompBarPage* Pages[int AIndex] = {read=GetPages};
	__property TLMDCompBarItem* SelectedItem = {read=FSelectedItem, write=SetSelectedItem};
	__property System::Classes::TComponentClass SelectedClass = {read=GetSelectedClass};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property TLMDComponentBarPageStyle PageStyle = {read=FPageStyle, write=SetPageStyle, default=0};
	__property Lmdtypes::TLMDString StandardPage = {read=FStandardPage, write=SetStandardPage, stored=IsStandardPageStored};
	__property Vcl::Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property System::Uitypes::TColor HotItemColor = {read=FHotItemColor, write=SetHotItemColor, default=15717318};
	__property System::Uitypes::TColor SelectedItemColor = {read=FSelectedItemColor, write=SetSelectedItemColor, default=14276054};
	__property Lmdsvcpvdr::TLMDServiceProvider* ServiceProvider = {read=FServiceProvider, write=SetServiceProvider};
	__property Vcl::Graphics::TFont* CategoryFont = {read=FCategoryFont, write=SetCategoryFont};
	__property bool AutoCollapse = {read=FAutoCollapse, write=SetAutoCollapse, default=0};
	__property TLMDComponentBarOnGetItemCaption OnGetItemCaption = {read=FOnGetItemCaption, write=FOnGetItemCaption};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Width = {default=188};
	__property Height = {default=193};
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
	/* TWinControl.CreateParented */ inline __fastcall TLMDComponentBar(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
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
class PASCALIMPLEMENTATION TLMDCompBarStyleHook : public Vcl::Forms::TScrollingStyleHook
{
	typedef Vcl::Forms::TScrollingStyleHook inherited;
	
public:
	/* TScrollingStyleHook.Create */ inline __fastcall virtual TLMDCompBarStyleHook(Vcl::Controls::TWinControl* AControl) : Vcl::Forms::TScrollingStyleHook(AControl) { }
	/* TScrollingStyleHook.Destroy */ inline __fastcall virtual ~TLMDCompBarStyleHook(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdidecompbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIDECOMPBAR)
using namespace Lmdidecompbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdidecompbarHPP
